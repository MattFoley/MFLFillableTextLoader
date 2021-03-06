# MFLFillableTextLoader
Loading/progress indicator based on filling stroked text.

![](http://i.imgur.com/8nVAZ6t.gif)

### Code Example
You can create an MFLFillableTextLoader either in a xib or in code. Here is a short code example:

```objc

  //Main text that will be stroked and filled.
    self.loader = [[MFLFillableTextLoader alloc] initWithString:@"Loading..."
                                                         font:[UIFont boldSystemFontOfSize:28]
                                                    alignment:NSTextAlignmentCenter
                                                    withFrame:CGRectMake(0, 0, 320, 400)];

  //Subheading displayed describing load
    NSAttributedString *details = [[NSAttributedString alloc] initWithString:@"Never tell me the odds."];
    [self.loader setDetailText:details];
    
  //Set the font used for the percentage of the load displayed.
    [self.loader setProgressFont:[UIFont systemFontOfSize:18]];
    
  //Properties used for stroking/filling the text.
    [self.loader setStrokeColor:UIColorFromRGB(0xe5b13a)];
    [self.loader setStrokeWidth:4];
```

### Usage

After creation, you can then add it to a UIView as a subview, and update the progress as you need to. It will automatically update it's fill.

```objc
    [self.view addSubview:self.loader];
    [self.loader setProgress:<Progress 0.0 - 1.0>];
```


### Further Customization

You can find a much more detailed example in the sample project found in this repo, with examples of both xib creation and in code, as well as an example animation to use.
