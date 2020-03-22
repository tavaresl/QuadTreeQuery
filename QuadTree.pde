import java.util.List;

class QuadTree<T extends Positionable>
{
  private AABB        boundaries;
  private int         capacity;
  private List<T>     elements;
  private boolean     subdivided;
  private QuadTree<T> northwest;
  private QuadTree<T> northeast;
  private QuadTree<T> southeast;
  private QuadTree<T> southwest;
  
  QuadTree(int capacity, AABB boundaries)
  {
    this.boundaries = boundaries;
    this.capacity   = capacity;
    elements        = new ArrayList<T>();
    subdivided      = false;
  }
  
  void insert(T element)
  {
    if (!boundaries.contains(element.getPosition()))
    {
      return;
    }
    
    if (elements.size() < capacity)
    {
      elements.add(element);
    }
    else
    {
       if (!subdivided)
       {
         subdivide();
       }

       northwest.insert(element);
       northeast.insert(element);
       southeast.insert(element);
       southwest.insert(element);
    }
  }
  
  List<T> query(AABB region)
  {
    ArrayList<T> found = new ArrayList<T>();
    
    if (!region.overlaps(boundaries))
    {
      return found;
    }
    
    for (Positionable element : elements)
    {
      if (region.contains(element.getPosition()))
      {
        found.add((T)element);
      }
    }
    
    if (subdivided)
    {
      found.addAll(northwest.query(region));
      found.addAll(northeast.query(region));
      found.addAll(southeast.query(region));
      found.addAll(southwest.query(region));
    }
    
    return found;
  }
  
  private void subdivide()
  {
    float halfWidth  = boundaries.getWidth() / 2;
    float halfHeight = boundaries.getHeight() / 2;
    
    northwest = new QuadTree<T>(capacity, new AABB(
      boundaries.getX(),
      boundaries.getY(),
      halfWidth,
      halfHeight
    ));
    
    northeast = new QuadTree<T>(capacity, new AABB(
      boundaries.getX() + halfWidth,
      boundaries.getY(),
      halfWidth,
      halfHeight
    ));
    
    southeast = new QuadTree<T>(capacity, new AABB(
      boundaries.getX() + halfWidth,
      boundaries.getY() + halfHeight,
      halfWidth,
      halfHeight
    ));

    southwest = new QuadTree<T>(capacity, new AABB( //<>//
      boundaries.getX(),
      boundaries.getY() + halfHeight,
      halfWidth,
      halfHeight
    ));
    
    subdivided = true;
  }
  
  void draw()
  {
     boundaries.draw();
     
     if (subdivided)
     {
       northwest.draw();
       northeast.draw();
       southeast.draw();
       southwest.draw();
     }
     
  }
}
