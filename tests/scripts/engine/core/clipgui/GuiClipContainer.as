package engine.core.clipgui
{
   import engine.core.animation.ZSortedSprite;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   public class GuiClipContainer extends GuiClipObject
   {
       
      
      protected var _container:DisplayObjectContainer;
      
      public function GuiClipContainer()
      {
         _container = !!_container?_container:new ZSortedSprite();
         super();
      }
      
      override public function get graphics() : DisplayObject
      {
         return _container;
      }
      
      override public function get container() : DisplayObjectContainer
      {
         return _container;
      }
      
      public function setChild(param1:DisplayObject, param2:Boolean) : void
      {
         if(param2)
         {
            if(param1.parent != container)
            {
               container.addChild(param1);
            }
         }
         else if(param1.parent == container)
         {
            container.removeChild(param1);
         }
      }
   }
}
