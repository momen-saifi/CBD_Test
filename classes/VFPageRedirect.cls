public class VFPageRedirect {
    public String inputValue { get; set; }

    public VFPageRedirect() {
        inputValue = 'test';  // Default value
    }

    public PageReference redirectToVFPage() {
        System.debug('Redirecting to VF page with inputValue: ' + inputValue); // Debug statement
        PageReference vfPageRef = Page.HelloLWCExampleVF;
        vfPageRef.getParameters().put('inputValue', inputValue);  // Pass value to VF page parameter
        System.debug('Page URL: ' + vfPageRef.getUrl());  // Debug statement
        vfPageRef.setRedirect(true);
        return vfPageRef;
    }
}