class Circle implements Positionable
{
  private PVector position;
  private float   radius;
  private boolean highlighted = false;
  
  Circle(float x, float y, float r)
  {
    position = new PVector(x, y);
    radius   = r;
  }
  
  PVector getPosition()
  {
    return position.copy();
  }
  
  void setHighlighted(boolean highlighted)
  {
    this.highlighted = highlighted;
  }
  
  void update()
  { 
    highlighted = false;
  }
  
  void draw()
  {
    push();
    noStroke();
    
    if (highlighted)
    {
      fill(180, 180, 0);
      circle(position.x, position.y, radius * 1.5);
    }
    else
    {
      circle(position.x, position.y, radius);
    }
    
    pop();
  }
}
