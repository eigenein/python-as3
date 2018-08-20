package game.view.gui.components
{
   import engine.core.clipgui.IGuiClip;
   import starling.display.DisplayObject;
   
   public class ClipVisibilityGroup
   {
       
      
      private var children:Array;
      
      private var objects:Vector.<DisplayObject>;
      
      public function ClipVisibilityGroup(param1:Array)
      {
         objects = new Vector.<DisplayObject>();
         super();
         this.children = param1;
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(children)
         {
            parseChidlren();
         }
         var _loc4_:int = 0;
         var _loc3_:* = objects;
         for each(var _loc2_ in objects)
         {
            _loc2_.visible = param1;
         }
      }
      
      protected function parseChidlren() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         if(children)
         {
            _loc3_ = children.length;
            _loc1_ = 0;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               var _loc5_:* = children[_loc4_];
               children[_loc4_ - _loc1_] = _loc5_;
               _loc2_ = _loc5_;
               if(_loc2_ is DisplayObject)
               {
                  objects.push(_loc2_ as DisplayObject);
               }
               else if(_loc2_ is IGuiClip && (_loc2_ as IGuiClip).graphics != null)
               {
                  objects.push((_loc2_ as IGuiClip).graphics);
               }
               _loc4_++;
            }
            if(_loc3_ == 0)
            {
               children = null;
            }
            else
            {
               children.length = _loc3_;
            }
         }
      }
   }
}
