class AABB
{
  private PVector position;
  private float   width;
  private float   height;
  
  AABB(float x, float y, float w, float h)
  {
    position = new PVector(x, y);
    width    = w;
    height   = h;
  }
  
  float getWidth()
  {
    return width;
  }
  
  float getHeight()
  {
    return height;
  }
  
  float getX()
  {
    return position.x;
  }
  
  float getY()
  {
    return position.y;
  }
  
  float getMaxX()
  {
    return position.x + width;
  }
  
  float getMaxY()
  {
    return position.y + height;
  }
  
  boolean contains(PVector point)
  {
    return (
      point.x >= position.x           &&
      point.x <= position.x + width   &&
      point.y >= position.y           &&
      point.y <= position.y + height
    );
  }
  
  boolean overlaps(AABB other)
  {
    return (
      this.getX()    <= other.getMaxX() &&
      this.getMaxX() >= other.getX()    &&
      this.getY()    <= other.getMaxY() &&
      this.getMaxY() >= other.getY()
    );  
  }

  void draw()
  {
    push();
    noFill();
    stroke(0, 200, 100);
    rect(position.x, position.y, width, height);
    pop();
  }
}
