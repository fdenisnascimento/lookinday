//
//  BaseTableViewCell.m
//  LookInDay
//
//  Created by Denis Nascimento on 11/24/15.
//  Copyright © 2015 Denis Nascimento. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "FIRFavorito.h"
#import "FIRScore.h"
#import "THSModel.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    
    self.btnDelete.enabled = NO;
    self.btnDelete.hidden =  YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    [self animeCellWithX:0.95 andY:0.95];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent* )event{
    
    [super touchesEnded:touches withEvent:event];
    [self animeCellWithX:1 andY:1];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent* )event{
    
    [super touchesCancelled:touches withEvent:event];
    [self animeCellWithX:1 andY:1];
}

- (void)animeCellWithX:(CGFloat)x andY:(CGFloat)y{
    
    [UIView animateWithDuration:0.10 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformMakeScale(x, y);
    } completion:^(BOOL finished){}];
}


- (IBAction)btnFavorito:(UIButton*)sender
{
    if (![[FIRAuth auth]currentUser]){
        return;
    }
    
    if (sender.selected)
    {
        self.btnFavorito.selected = NO;
        
        [THSModel removeFavorite:self.currentPost.uid completion:^(BOOL success, id result) {
            
        }];
        
    }
    else
    {
        FIRFavorito *favorito = [FIRFavorito new];
        [favorito config];
        
        favorito.user       = [FIRAuth auth].currentUser;
        favorito.post       = self.currentPost;
        [favorito save:^(BOOL success, id result) {
            if (!success)
            {
                self.btnFavorito.selected = NO;
            }
            else
            {
                self.btnFavorito.selected = YES;
            }
        }];
    }
    
}

-(void)checkFavoritos
{
    
    if ([[FIRAuth auth]currentUser]){
        [THSModel hasFavorite:self.currentPost.uid completion:^(BOOL success, id result) {
            
            BOOL has = ((FIRDataSnapshot*)result).hasChildren;
            if (has) {
                self.btnFavorito.selected = YES;
                self.currentFavorito = ((FIRDataSnapshot*)result).value;
            }else{
                self.btnFavorito.selected = NO;
            }
            
        }];
    }
    
}


-(void)checkRatting
{
    [FIRScore ratingFromPost:self.currentPost.uid completion:^(BOOL success, id result) {
        NSNumber *number = (NSNumber*)result;
        [self.starRatingView setStars:number.intValue];
    }];
}


-(void)checkCountPost
{
    [THSModel countFromPost:self.currentPost.uid completion:^(BOOL success, id result) {
        NSNumber *count = (NSNumber*)result;
        if (count.intValue >1)
            self.labelComentarios.text =[NSString stringWithFormat:@"%@ Comentários",count.stringValue];
        else
            self.labelComentarios.text =[NSString stringWithFormat:@"%@ Comentário",count.stringValue];
    }];
}

- (IBAction)btnDelete:(UIButton*)sender {
    
    if (_currentPost ) {
        [[[UIAlertView alloc]initWithTitle:@"Look In Day"  message:@"Confirma que deseja excluir esse post?" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Confirmo", nil]show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex ==  1) {
        
        [THSModel removePost:self.currentPost.uid completion:^(BOOL success, id result) {
            
        }];
    }
}


@end
