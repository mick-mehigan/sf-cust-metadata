public class FieldMapping {
  public String src { get; private set; }
  public String dest { get; private set; }
  public FieldMapping(string src, String dest) {
    this.src = src;
    this.dest = dest;
  }
}