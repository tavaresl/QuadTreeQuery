QuadTree<Circle> qt;
AABB mouseRegion;

int      count        = 1000;
float    regionWidth  = 100;
float    regionHeight = 100;
Circle[] circles      = new Circle[count];


void mouseMoved()
{
  mouseRegion = new AABB(mouseX - regionWidth / 2, mouseY - regionHeight / 2, regionWidth, regionHeight);
}

void setup()
{
  size(800, 600);

  mouseRegion = new AABB(mouseX - regionWidth / 2, mouseY - regionHeight / 2, regionWidth, regionHeight);

  for (int i = 0; i < count; i++)
  {
    Circle circle = new Circle(random(width), random(height), 5);
    circles[i] = circle;
  }
}

void draw()
{
  background(0);
  qt = new QuadTree<Circle>(1, new AABB(0, 0, width, height));

  for (int i = 0; i < count; i++)
  {
    qt.insert(circles[i]);
    circles[i].update();
    circles[i].draw();
  }
  
  List<Circle> found = qt.query(mouseRegion);
  
  for (Circle circle : found)
  {
    circle.setHighlighted(true);
    circle.draw();
  }
  mouseRegion.draw();
}
