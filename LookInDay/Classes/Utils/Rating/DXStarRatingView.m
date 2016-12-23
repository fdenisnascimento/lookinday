/*
 Copyright (c) 2014 Selvin
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "DXStarRatingView.h"

#define kStarPadding 6.0

#define kRatingStarOnImage1 [UIImage imageNamed:@"icon_coracao_small_on.png"]
#define kRatingStarOffImage1 [UIImage imageNamed:@"icon_coracao_small_off.png"]

#define kRatingStarOnImage2 [UIImage imageNamed:@"icon_coracao_alert_on.png"]
#define kRatingStarOffImage2 [UIImage imageNamed:@"icon_coracao_alert_off.png"]

@interface DXStarRatingView ()
{
    int _stars;
    id _target;
    SEL _callBackAction;
    DXStarRatingViewCallBack _callBackBlock;
    
    BOOL _isInitialized;
}

@end

@implementation DXStarRatingView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
      _enabledVoto = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
      _enabledVoto = NO;
    }
    return self;
}

- (void)awakeFromNib
{
    [self performSelector:@selector(setupInterface) withObject:nil afterDelay:0.1];
}

- (void)setStars:(int)stars
{
    _stars = stars;
    [self setupInterface];
}

- (void)setStars:(int)stars callbackBlock:(DXStarRatingViewCallBack)callBackBlock
{
    _stars = stars;
    [self setupInterface];
    _callBackBlock = [callBackBlock copy];
}

- (void)setStars:(int)stars target:(id)target callbackAction:(SEL)callBackAction
{
    _stars = stars;
    _target = target;
    _callBackAction = callBackAction;
    [self setupInterface];
}

- (void)setupInterface
{
    if (_isInitialized) {
        //if the star rating view is already set then no need to do it all over again
        [self updateStarUI];
        return;
    }
    [[self subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];

  UIImage *starImageOn = kRatingStarOnImage1;
  UIImage *starImageOff = kRatingStarOffImage1;

  if (self.type == 2)
  {
    starImageOn = kRatingStarOnImage2;
    starImageOff = kRatingStarOffImage2;
  }
  
    
    CGRect frame = self.frame;
    frame.size.height = starImageOn.size.height;
    frame.size.width = ((starImageOn.size.width*5)+(4*kStarPadding));
    self.frame = frame;
    
    CGFloat xOrigin = 0.0f;
    for (int counter=1; counter<=5; counter++) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:(counter<=_stars)?starImageOn:starImageOff];
        [imageView sizeToFit];
        frame = imageView.frame;
        frame.origin.x = xOrigin;
        frame.origin.y=0;
        imageView.frame=frame;
        imageView.tag=counter;
        
        
        [self addSubview:imageView];
        xOrigin+=starImageOn.size.width + kStarPadding;
    }
    _isInitialized = YES;
  
  if (self.enabledVoto)
    self.userInteractionEnabled = YES;
  else
    self.userInteractionEnabled = NO;
}

//-(void)didTapImage:(UIButton*)button
//{
//    _stars =  (int)button.tag;
//    [self updateStarUI];
//     [self performCallBackWithStarValue];
//}

- (void)updateStarUI
{
    UIImage *starImageOn = kRatingStarOnImage1;
    UIImage *starImageOff = kRatingStarOffImage1;
    if (self.type == 2)
    {
      starImageOn = kRatingStarOnImage2;
      starImageOff = kRatingStarOffImage2;
    }
  
    for (int counter=1; counter<=5; counter++) {
        UIImageView *imageView = (UIImageView*)[self viewWithTag:counter];
        imageView.image = (counter<=_stars)?starImageOn:starImageOff;
    }

}

#define kQuarterStarDivident 20.0

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   [self handleStarTouches:touches withEvent:event];
 }

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self handleStarTouches:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self handleStarTouches:touches withEvent:event];
    [self performCallBackWithStarValue];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self updateStarUI];
    [self performCallBackWithStarValue];
}

- (void)handleStarTouches:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (CGRectContainsPoint(self.bounds, [[[touches allObjects]lastObject] locationInView:self])) {
        
        float xpos = [[[touches allObjects]lastObject] locationInView:self].x;
        _stars = xpos/((self.bounds.size.width)/5.0f)+1;
        
        if (_stars==1) {
            if (xpos<(self.bounds.size.width/kQuarterStarDivident)) {
                //if user slides below half star then make it zero
                _stars=0;
            }
        }
        [self updateStarUI];
    }
}

#pragma mark - call back target -

- (void)performCallBackWithStarValue
{
    if (_callBackAction) {
       [_target performSelectorOnMainThread:_callBackAction withObject:@(_stars) waitUntilDone:YES];
    }
    if (_callBackBlock) {
        _callBackBlock([NSNumber numberWithInt:_stars]);
    }
}

@end
