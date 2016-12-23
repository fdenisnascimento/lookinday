//
//  AddPostViewController.m
//  LookInDay
//
//  Created by Denis Nascimento on 6/17/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import "AddEnqueteViewController.h"
#import "UIImage+Utilities.h"
#import "FIRPost.h"

@interface AddEnqueteViewController ()<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIActionSheet *shareActionSheet;
@property (nonatomic, strong) UIImage *currentImage1;
@property (nonatomic, strong) UIImage *currentImage2;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation AddEnqueteViewController


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
    self.currentIndex = -1;
    self.btnSend.layer.cornerRadius = 5;
    self.textView.layer.borderColor = [[UIColor colorWithWhite:0.886 alpha:1.000]CGColor];
    self.textView.layer.borderWidth = 2;
    self.title = @"Nova Enquete";
    self.textView.placeholderText = @"Descrição da Enquete";
    self.lastVisibleView = self.btnSend;
    self.labelOU.layer.cornerRadius = self.labelOU.frame.size.height/2;
    self.labelOU.clipsToBounds = YES;
    
    //  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignFirstResponder)];
    //  [self.view addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tapImageCapa1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapImageCapa:)];
    [self.imageCapa1 addGestureRecognizer:tapImageCapa1];
    self.imageCapa1.tag = 1000;
    
    UITapGestureRecognizer *tapImageCapa2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapImageCapa:)];
    [self.imageCapa2 addGestureRecognizer:tapImageCapa2];
    self.imageCapa2.tag = 2000;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setShareActionSheet:(UIActionSheet *)shareActionSheet
{
    if (![_shareActionSheet isEqual:shareActionSheet]) {
        _shareActionSheet.delegate = nil;
        _shareActionSheet = shareActionSheet;
    }
}

-(void)didTapImageCapa:(UIGestureRecognizer*)gesture
{
    self.currentIndex = gesture.view.tag;
    
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

- (IBAction)btnSend:(UIButton *)sender
{
    NSLog(@"btnSend");
    
    [self.textView resignFirstResponder];
    
    if (self.textView.text.length <= 1)
    {
        [[[UIAlertView alloc]initWithTitle:@"Look In Day" message:@"Precisa escrever uma breve descrição da enquete" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
        return;
    }
    
    [self savePostWithImage:self.imageCapa1.image image2:self.imageCapa2.image description:self.textView.text];
}


#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.currentImage1 = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    if (self.currentIndex == 1000)
    {
        [self.imageCapa1 setImage:self.currentImage1];
    }
    
    if (self.currentIndex == 2000)
    {
        [self.imageCapa2 setImage:self.currentImage1];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)savePostWithImage:(UIImage*)image1 image2:(UIImage*)image2 description:(NSString*)description
{
    [self startAnimate];
    NSData *imageData1 = UIImageJPEGRepresentation(image1, 1) ;
    NSData *imageData2 = UIImageJPEGRepresentation(image2, 1) ;

    FIRPost *post = [FIRPost new];
    [post config];
    
    post.descriptionValue = description;
    
    post.postType = self.postType;
    post.scoreimage1 = [NSNumber numberWithInteger:0];
    post.scoreimage2 = [NSNumber numberWithInteger:0];
    post.image1 = imageData1;
    post.image2 = imageData2;
    post.userName = [FIRAuth auth].currentUser.displayName;
    post.userPhoto = [FIRAuth auth].currentUser.photoURL.absoluteString;
    
    
    [post savePost:^(BOOL success, id result) {
        
        if (!success)
        {
            NSLog(@"error");
        }
        [self stopAnimate];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    
    

    
}


@end
