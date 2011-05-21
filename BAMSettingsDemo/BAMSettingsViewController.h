//
//  BAMSettingsViewController.h
//  BAMSettings
//
//  Created by Barry Murphy on 4/5/11.
//
//  If you use this software in your project, a credit for Barry Murphy
//  and a link to http://barrycenter.com would be appreciated.
//
//  --------------------------------
//  Simplified BSD License (FreeBSD)
//  --------------------------------
//
//  Copyright 2011 Barry Murphy. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are
//  permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of
//     conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list
//     of conditions and the following disclaimer in the documentation and/or other materials
//     provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY BARRY MURPHY "AS IS" AND ANY EXPRESS OR IMPLIED
//  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
//  FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL BARRY MURPHY OR
//  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
//  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those of the
//  authors and should not be interpreted as representing official policies, either expressed
//  or implied, of Barry Murphy.
//

#import <UIKit/UIKit.h>

/*****************************************************************************\
 *                                                                           *
 *                      BAMSettingsDetailViewController                      *
 *                                                                           *
 *  This class displays a table of options for a multi-value setting type.   *
 *                                                                           *
\*****************************************************************************/

@protocol BAMSettingsDetailViewDelegate <NSObject>
- (void)settingsDetailSelectedRow:(NSInteger)row forCellIndexPath:(NSIndexPath *)indexPath;
@end

@interface BAMSettingsDetailViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
    id<BAMSettingsDetailViewDelegate> delegate;
@private
    NSInteger selectedRow;
    NSIndexPath *cellIndexPath;
    NSString *title;
    NSArray *rowTitles;
}
@property (assign) id<BAMSettingsDetailViewDelegate> delegate;

- (id)initWithTitle:(NSString *)aTitle rowTitles:(NSArray *)theRowTitles selectedRow:(NSInteger)aSelectedRow forCellAtIndexPath:(NSIndexPath *)anIndexPath;
@end


/*****************************************************************************\
 *                                                                           *
 *                         BAMSettingsViewController                         *
 *                                                                           *
 *  This class diplays a table view for the options in the specified plist.  *
 *                                                                           *
\*****************************************************************************/

@protocol BAMSettingsViewDelegate <NSObject>
@optional
- (void)settingsViewDidChangeValueForKey:(NSString *)key;
- (void)settingsViewExitedWithChangedValues:(BOOL)didChange;
- (void)settingsViewNavigatedAwayFromPane:(NSString *)propertyListName withChangedValues:(BOOL)didChange;
@end

@interface BAMSettingsViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, BAMSettingsDetailViewDelegate> {
    id<BAMSettingsViewDelegate> delegate;
@private
    BOOL isChildPane;
    NSString *paneTitle, *propertyListName, *stringsTable;
    NSBundle *settingsBundle;
    NSMutableArray *sectionHeaders, *sectionFooters, *sections;
}
@property (assign) id<BAMSettingsViewDelegate> delegate;

- (id)initWithTitle:(NSString *)aTitle propertyListNamed:(NSString *)aPropertyListName;

@end