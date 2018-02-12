public class CustomMetadataCallback implements Metadata.DeployCallback {
  private Boolean deployResult;

  public void handleResult(Metadata.DeployResult result,
                           Metadata.DeployCallbackContext context) {
    if (result.status == Metadata.DeployStatus.Succeeded) {
      System.debug('CustomMetadataCallback success: ' + result);
      deployResult = true;
    } else {
      System.debug('CustomMetadataCallback failure: ' + result);
      deployResult = false;
    }
  }
}