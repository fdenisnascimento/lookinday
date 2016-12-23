//
//  AddPostViewController.m
//  LookInDay
//
//  Created by Denis Nascimento on 6/17/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import "AddPostViewController.h"
#import "UIImage+Utilities.h"
#import "FIRPost.h"


#define IMAGE_WIDTH 640.0f
#define IMAGE_HEIGHT 640.0f

@interface AddPostViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIActionSheet *shareActionSheet;
@property (nonatomic, strong) UIImage *currentImage;

@end

@implementation AddPostViewController


-(void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self setStyleDefault];
  [self startKeyboardObserver];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  self.btnSend.layer.cornerRadius = 5;
  self.textView.layer.borderColor = [[UIColor colorWithWhite:0.886 alpha:1.000]CGColor];
  self.textView.layer.borderWidth = 2;
  self.textView.placeholderColor = [UIColor grayColor];
  self.title = @"Novo Post";

  self.lastVisibleView = self.btnSend;
  [self updateContent];
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignFirstResponder)];
  [self.view addGestureRecognizer:tap];

  
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
}

-(void)dealloc
{
    // [self stopKeyboardObserver];
}

- (void)viewDidTap:(UIView *)view
{
  for (UIView *subview in self.view.subviews)
  {
    if ([subview isMemberOfClass:[UITextField class]])
      [((UITextField *)subview) resignFirstResponder];
  }
}

- (void)setShareActionSheet:(UIActionSheet *)shareActionSheet
{
  if (![_shareActionSheet isEqual:shareActionSheet]) {
    _shareActionSheet.delegate = nil;
    _shareActionSheet = shareActionSheet;
  }
}

-(IBAction)didTapImageCapa:(UIButton*)button
{
  UIActionSheet *shareActionSheet = self.shareActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                                        delegate:self
                                                                               cancelButtonTitle:nil
                                                                          destructiveButtonTitle:nil
                                                                               otherButtonTitles:nil];
  
  
  [shareActionSheet addButtonWithTitle:@"Tirar Foto"];
  [shareActionSheet addButtonWithTitle:@"Escolher da Galeria"];
  [shareActionSheet addButtonWithTitle:@"Cancelar"];

  
  shareActionSheet.cancelButtonIndex = shareActionSheet.numberOfButtons - 1;
  [shareActionSheet showInView:self.view];

}

- (void)share:(id)sender
{
  }

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
  if (_shareActionSheet != actionSheet)
  {
    return;
  }
  
  NSLog(@"buttonIndex:%ld",(long)buttonIndex);
  
  
  switch (buttonIndex)
  {
    case 0:
      [self takeCam];
      break;
    case 1:
      [self takeGallery];
      break;
    default:
      break;
  }
  _shareActionSheet = nil;
}

-(void)takeCam
{
  NSLog(@"takeCam");
  
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
  {
    UIImagePickerController *cam = [[UIImagePickerController alloc] init];
    cam.sourceType = UIImagePickerControllerSourceTypeCamera;
    cam.showsCameraControls = YES;
    cam.allowsEditing = YES;
    cam.delegate = self;
    [self presentViewController:cam animated:YES completion:nil];
    
  }

  
}
-(void)takeGallery
{
  NSLog(@"takeGallery");
  UIImagePickerController  *photo = [[UIImagePickerController alloc] init];
  photo.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
  photo.delegate = self;
  photo.allowsEditing = YES;
  [self presentViewController:photo animated:YES completion:nil];
}

-(void)updateContent
{
  switch (self.postType) {
    case AddPostTypeLook:
      self.textView.placeholderText = @"Descrição do Look";
      break;
    case AddPostTypeDica:
      self.textView.placeholderText = @"Descrição da Dica";
      break;
      
    default:
      break;
  }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btnSend:(UIButton *)sender
{
  NSLog(@"btnSend");
  
  [self.textView resignFirstResponder];
  
  if (self.textView.text.length <= 1)
  {
    [[[UIAlertView alloc]initWithTitle:@"Look In Day" message:@"Precisa escrever uma breve descricao do look" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
    return;
  }
  
  [self savePostWithImage:self.currentImage description:self.textView.text];
}


#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  
  self.currentImage = [info objectForKey:UIImagePickerControllerOriginalImage];
  
  CGRect cropRect = [[info valueForKey:UIImagePickerControllerCropRect] CGRectValue];
  UIImage *originalImage = [info valueForKey:UIImagePickerControllerOriginalImage];
  
  cropRect = [originalImage convertCropRect:cropRect];
  
  UIImage *croppedImage = [originalImage croppedImage:cropRect];
  UIImage *resizedImage = [croppedImage resizedImage:CGSizeMake(640,640) imageOrientation:originalImage.imageOrientation];
  
  self.currentImage = resizedImage;
  [self.imageCapa setImage:self.currentImage forState:UIControlStateNormal];
  
  if (picker.sourceType ==  UIImagePickerControllerSourceTypeCamera)
  {
    UIImageWriteToSavedPhotosAlbum(self.currentImage, nil, nil, nil);
  }
  
  [self dismissViewControllerAnimated:YES completion:^{
    
  }];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)savePostWithImage:(UIImage*)image description:(NSString*)description
{
  
  [self startAnimate];
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
    
      NSData *imageData = UIImageJPEGRepresentation(image, 1) ;
      FIRPost *post = [FIRPost new];
      [post config];
      post.descriptionValue = description;
      post.postType = self.postType;
      post.image1 = imageData;
      post.userPhoto = [FIRAuth auth].currentUser.photoURL.absoluteString;
      post.userName = [FIRAuth auth].currentUser.displayName;
      post.scoreimage1 = [NSNumber numberWithInteger:0];
      post.scoreimage2 = [NSNumber numberWithInteger:0];

      [post savePost:^(BOOL success, id result) {
          if (success) {
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self stopAnimate];
                  [self.navigationController popViewControllerAnimated:YES];
              });
          }else{
              NSLog(@"error");
          }
      }];

  });
  

}


@end
