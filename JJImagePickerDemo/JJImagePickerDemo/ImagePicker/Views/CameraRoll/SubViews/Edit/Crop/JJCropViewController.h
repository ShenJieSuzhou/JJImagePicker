//
//  JJCropViewController.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/8/17.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditingToolView.h"

#import "TOCropViewControllerTransitioning.h"
#import "TOActivityCroppedImageProvider.h"
#import "UIImage+CropRotate.h"
#import "TOCroppedImageAttributes.h"
#import "TOCropViewConstants.h"
#import "TOCropView.h"

@class JJCropViewController;

@protocol TOCropViewControllerDelegate <NSObject>
@optional

/**
 Called when the user has committed the crop action, and provides
 just the cropping rectangle.
 
 @param cropRect A rectangle indicating the crop region of the image the user chose (In the original image's local co-ordinate space)
 @param angle The angle of the image when it was cropped
 */
- (void)cropViewController:(nonnull JJCropViewController *)cropViewController didCropImageToRect:(CGRect)cropRect angle:(NSInteger)angle NS_SWIFT_NAME(cropViewController(_:didCropImageToRect:angle:));

/**
 Called when the user has committed the crop action, and provides
 both the original image with crop co-ordinates.
 
 @param image The newly cropped image.
 @param cropRect A rectangle indicating the crop region of the image the user chose (In the original image's local co-ordinate space)
 @param angle The angle of the image when it was cropped
 */
- (void)cropViewController:(nonnull JJCropViewController *)cropViewController didCropToImage:(nonnull UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle NS_SWIFT_NAME(cropViewController(_:didCropToImage:rect:angle:));

/**
 If the cropping style is set to circular, implementing this delegate will return a circle-cropped version of the selected
 image, as well as it's cropping co-ordinates
 
 @param image The newly cropped image, clipped to a circle shape
 @param cropRect A rectangle indicating the crop region of the image the user chose (In the original image's local co-ordinate space)
 @param angle The angle of the image when it was cropped
 */
- (void)cropViewController:(nonnull JJCropViewController *)cropViewController didCropToCircularImage:(nonnull UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle NS_SWIFT_NAME(cropViewController(_:didCropToCircleImage:rect:angle:));

/**
 If implemented, when the user hits cancel, or completes a
 UIActivityViewController operation, this delegate will be called,
 giving you a chance to manually dismiss the view controller
 
 @param cancelled Whether a cropping action was actually performed, or if the user explicitly hit 'Cancel'
 
 */
- (void)cropViewController:(nonnull JJCropViewController *)cropViewController didFinishCancelled:(BOOL)cancelled NS_SWIFT_NAME(cropViewController(_:didFinishCancelled:));

@end


@interface JJCropViewController : UIViewController<PhotoSubToolEditingDelegate, UIViewControllerTransitioningDelegate, TOCropViewDelegate>
//原始图
@property (nonnull, nonatomic, readonly) UIImage *image;


/**
 The minimum croping aspect ratio. If set, user is prevented from setting cropping rectangle to lower aspect ratio than defined by the parameter.
 */
@property (nonatomic, assign) CGFloat minimumAspectRatio;

/**
 The view controller's delegate that will receive the resulting
 cropped image, as well as crop information.
 */
@property (nullable, nonatomic, weak) id<TOCropViewControllerDelegate> delegate;

/**
 If true, when the user hits 'Done', a UIActivityController will appear
 before the view controller ends.
 */
@property (nonatomic, assign) BOOL showActivitySheetOnDone;

/**
 The crop view managed by this view controller.
 */
@property (nonnull, nonatomic, strong, readonly) TOCropView *cropView;

/**
 In the coordinate space of the image itself, the region that is currently
 being highlighted by the crop box.
 
 This property can be set before the controller is presented to have
 the image 'restored' to a previous cropping layout.
 */
@property (nonatomic, assign) CGRect imageCropFrame;

/**
 The angle in which the image is rotated in the crop view.
 This can only be in 90 degree increments (eg, 0, 90, 180, 270).
 
 This property can be set before the controller is presented to have
 the image 'restored' to a previous cropping layout.
 */
@property (nonatomic, assign) NSInteger angle;



/**
 A choice from one of the pre-defined aspect ratio presets
 */
@property (nonatomic, assign) TOCropViewControllerAspectRatioPreset aspectRatioPreset;

/**
 A CGSize value representing a custom aspect ratio, not listed in the presets.
 E.g. A ratio of 4:3 would be represented as (CGSize){4.0f, 3.0f}
 */
@property (nonatomic, assign) CGSize customAspectRatio;

/**
 If true, a custom aspect ratio is set, and the aspectRatioLockEnabled is set to YES, the crop box will swap it's dimensions depending on portrait or landscape sized images.  This value also controls whether the dimensions can swap when the image is rotated.
 
 Default is NO.
 */
@property (nonatomic, assign) BOOL aspectRatioLockDimensionSwapEnabled;

/**
 If true, while it can still be resized, the crop box will be locked to its current aspect ratio.
 
 If this is set to YES, and `resetAspectRatioEnabled` is set to NO, then the aspect ratio
 button will automatically be hidden from the toolbar.
 
 Default is NO.
 */
@property (nonatomic, assign) BOOL aspectRatioLockEnabled;

/**
 If true, tapping the reset button will also reset the aspect ratio back to the image
 default ratio. Otherwise, the reset will just zoom out to the current aspect ratio.
 
 If this is set to NO, and `aspectRatioLockEnabled` is set to YES, then the aspect ratio
 button will automatically be hidden from the toolbar.
 
 Default is YES
 */
@property (nonatomic, assign) BOOL resetAspectRatioEnabled;

/**
 The position of the Toolbar the default value is `TOCropViewControllerToolbarPositionBottom`.
 */
@property (nonatomic, assign) TOCropViewControllerToolbarPosition toolbarPosition;

/**
 When disabled, an additional rotation button that rotates the canvas in
 90-degree segments in a clockwise direction is shown in the toolbar.
 
 Default is NO.
 */
@property (nonatomic, assign) BOOL rotateClockwiseButtonHidden;

/**
 When enabled, hides the rotation button, as well as the alternative rotation
 button visible when `showClockwiseRotationButton` is set to YES.
 
 Default is NO.
 */
@property (nonatomic, assign) BOOL rotateButtonsHidden;

/**
 When enabled, hides the 'Aspect Ratio Picker' button on the toolbar.
 
 Default is NO.
 */
@property (nonatomic, assign) BOOL aspectRatioPickerButtonHidden;

/**
 If `showActivitySheetOnDone` is true, then these activity items will
 be supplied to that UIActivityViewController in addition to the
 `TOActivityCroppedImageProvider` object.
 */
@property (nullable, nonatomic, strong) NSArray *activityItems;

/**
 If `showActivitySheetOnDone` is true, then you may specify any
 custom activities your app implements in this array. If your activity requires
 access to the cropping information, it can be accessed in the supplied
 `TOActivityCroppedImageProvider` object
 */
@property (nullable, nonatomic, strong) NSArray<UIActivity *> *applicationActivities;

/**
 If `showActivitySheetOnDone` is true, then you may expliclty
 set activities that won't appear in the share sheet here.
 */
@property (nullable, nonatomic, strong) NSArray<UIActivityType> *excludedActivityTypes;

/**
 When the user hits cancel, or completes a
 UIActivityViewController operation, this block will be called,
 giving you a chance to manually dismiss the view controller
 */
@property (nullable, nonatomic, strong) void (^onDidFinishCancelled)(BOOL isFinished);

/**
 Called when the user has committed the crop action, and provides
 just the cropping rectangle.
 
 @param cropRect A rectangle indicating the crop region of the image the user chose (In the original image's local co-ordinate space)
 @param angle The angle of the image when it was cropped
 */
@property (nullable, nonatomic, strong) void (^onDidCropImageToRect)(CGRect cropRect, NSInteger angle);

/**
 Called when the user has committed the crop action, and provides
 both the cropped image with crop co-ordinates.
 
 @param image The newly cropped image.
 @param cropRect A rectangle indicating the crop region of the image the user chose (In the original image's local co-ordinate space)
 @param angle The angle of the image when it was cropped
 */
@property (nullable, nonatomic, strong) void (^onDidCropToRect)(UIImage* _Nonnull image, CGRect cropRect, NSInteger angle);

/**
 If the cropping style is set to circular, this block will return a circle-cropped version of the selected
 image, as well as it's cropping co-ordinates
 
 @param image The newly cropped image, clipped to a circle shape
 @param cropRect A rectangle indicating the crop region of the image the user chose (In the original image's local co-ordinate space)
 @param angle The angle of the image when it was cropped
 */
@property (nullable, nonatomic, strong) void (^onDidCropToCircleImage)(UIImage* _Nonnull image, CGRect cropRect, NSInteger angle);


///------------------------------------------------
/// @name Object Creation
///------------------------------------------------

/**
 Resets object of TOCropViewController class as if user pressed reset button in the bottom bar themself
 */
- (void)resetCropViewLayout;

/**
 Set the aspect ratio to be one of the available preset options. These presets have specific behaviour
 such as swapping their dimensions depending on portrait or landscape sized images.
 
 @param aspectRatioPreset The aspect ratio preset
 @param animated Whether the transition to the aspect ratio is animated
 */
- (void)setAspectRatioPreset:(TOCropViewControllerAspectRatioPreset)aspectRatioPreset animated:(BOOL)animated NS_SWIFT_NAME(setAspectRatioPresent(_:animated:));




@property (nonatomic, strong) NSMutableArray *optionsAray;

@property (nonatomic, strong) EditingSubToolView *editSubToolView;

@property (nonatomic, readonly) TOCropViewCroppingStyle croppingStyle;

/* Transition animation controller */
@property (nonatomic, copy) void (^prepareForTransitionHandler)(void);
@property (nonatomic, strong) TOCropViewControllerTransitioning *transitionController;
@property (nonatomic, assign) BOOL inTransition;

- (instancetype)initWithCroppingStyle:(TOCropViewCroppingStyle)style image:(UIImage *)image;

@end
