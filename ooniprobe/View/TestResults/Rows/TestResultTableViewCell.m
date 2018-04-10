#import "TestResultTableViewCell.h"

@implementation TestResultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setResult:(Result*)result{
    if (!result.viewed)
        [self setBackgroundColor:[UIColor colorWithRGBHexString:color_yellow5 alpha:1.0f]];
    else
        [self setBackgroundColor:[UIColor clearColor]];

    [self.testIcon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_row", result.name]]];
    self.testNameLabel.text  = [LocalizationUtility getNameForTest:result.name];
    NSString *asn = [result getAsn];
    NSString *asnName = [result getAsnName];
    NSString *country = [result getCountry];
    
    NSMutableAttributedString *asnNameAttr = [[NSMutableAttributedString alloc] initWithString:asnName];
    [asnNameAttr addAttribute:NSFontAttributeName
                        value:[UIFont fontWithName:@"FiraSans-SemiBold" size:17]
                        range:NSMakeRange(0, asnNameAttr.length)];
    NSString *asnString = [NSString stringWithFormat:@" %@", [NSString stringWithFormat:@"%@ (%@)", asn, country]];
    if ([asnString isEqualToString:@"  ()"])
        asnString = NSLocalizedString(@"unknown", nil);
    NSMutableAttributedString *asnText = [[NSMutableAttributedString alloc] initWithString:asnString];
    [asnText addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"FiraSans-Regular" size:17]
                    range:NSMakeRange(0, asnText.length)];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] init];
    [attrStr appendAttributedString:asnNameAttr];
    [attrStr appendAttributedString:asnText];
    [self.testAsnLabel setAttributedText:attrStr];
    
    //from https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/InternationalizingLocaleData/InternationalizingLocaleData.html
    NSString *localizedDateTime = [NSDateFormatter localizedStringFromDate:result.startTime dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    self.testTimeLabel.text = localizedDateTime;
    Summary *summary = [result getSummary];
    if ([result.name isEqualToString:@"websites"]){
        [self.stackView2 setHidden:NO];
        [self.stackView3 setHidden:YES];
        [self.image1 setImage:[UIImage imageNamed:@"x_red"]];
        [self.label1 setText:[NSString stringWithFormat:@"%d %@", summary.blockedMeasurements, NSLocalizedString(@"TestResults.Overview.Websites.Blocked", nil)]];
        [self.label1 setTextColor:[UIColor colorWithRGBHexString:color_red8 alpha:1.0f]];
        [self.image2 setImage:[UIImage imageNamed:@"globe_black"]];
        [self.label2 setText:[NSString stringWithFormat:@"%d %@", summary.totalMeasurements, NSLocalizedString(@"TestResults.Overview.Websites.Tested", nil)]];
        [self.label2 setTextColor:[UIColor colorWithRGBHexString:color_black alpha:1.0f]];
    }
    else if ([result.name isEqualToString:@"instant_messaging"]){
        [self.stackView2 setHidden:NO];
        [self.stackView3 setHidden:YES];
        [self.image1 setImage:[UIImage imageNamed:@"x_red"]];
        [self.label1 setText:[NSString stringWithFormat:@"%d %@", summary.blockedMeasurements, NSLocalizedString(@"TestResults.Overview.InstantMessaging.Blocked", nil)]];
        [self.label1 setTextColor:[UIColor colorWithRGBHexString:color_red8 alpha:1.0f]];
        [self.image2 setImage:[UIImage imageNamed:@"tick_black"]];
        [self.label2 setText:[NSString stringWithFormat:@"%d %@", summary.okMeasurements, NSLocalizedString(@"TestResults.Overview.InstantMessaging.Available", nil)]];
        [self.label2 setTextColor:[UIColor colorWithRGBHexString:color_black alpha:1.0f]];
    }
    else if ([result.name isEqualToString:@"middle_boxes"]){
        [self.stackView2 setHidden:YES];
        [self.stackView3 setHidden:YES];
        [self.image1 setImage:nil];
        if (summary.failedMeasurements > 0)
            [self.label1 setText:NSLocalizedString(@"TestResults.Overview.MiddleBoxes.Found", nil)];
        else if (summary.okMeasurements == summary.totalMeasurements)
            [self.label1 setText:NSLocalizedString(@"TestResults.Overview.MiddleBoxes.NotFound", nil)];
        else
            [self.label1 setText:NSLocalizedString(@"TestResults.Overview.MiddleBoxes.Failed", nil)];

        [self.label1 setTextColor:[UIColor colorWithRGBHexString:color_yellow8 alpha:1.0f]];
    }
    else if ([result.name isEqualToString:@"performance"]){
        [self.stackView2 setHidden:NO];
        [self.stackView3 setHidden:NO];
        [self.image1 setImage:[UIImage imageNamed:@"upload_black"]];
        [self.label1 setText:[NSString stringWithFormat:@"%@", [summary getUploadWithUnit]]];
        [self.label1 setTextColor:[UIColor colorWithRGBHexString:color_black alpha:1.0f]];
        [self.image2 setImage:[UIImage imageNamed:@"download_black"]];
        [self.label2 setText:[NSString stringWithFormat:@"%@", [summary getDownloadWithUnit]]];
        [self.label2 setTextColor:[UIColor colorWithRGBHexString:color_black alpha:1.0f]];
        [self.image3 setImage:[UIImage imageNamed:@"video_quality_black"]];
        [self.label3 setText:[summary getVideoQuality:YES]];
        [self.label3 setTextColor:[UIColor colorWithRGBHexString:color_black alpha:1.0f]];
    }
}

@end
