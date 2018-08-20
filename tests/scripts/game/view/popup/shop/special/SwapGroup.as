package game.view.popup.shop.special
{
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   public class SwapGroup
   {
       
      
      private var _parent:DisplayObjectContainer;
      
      private var _topChild:DisplayObject;
      
      public function SwapGroup()
      {
         super();
      }
      
      public function addChild(param1:DisplayObject) : void
      {
         if(param1.parent == null)
         {
            return;
         }
         if(_parent == null)
         {
            _parent = param1.parent;
         }
         if(param1.parent != _parent)
         {
            return;
         }
         if(_topChild == null || _parent.getChildIndex(param1) > _parent.getChildIndex(_topChild))
         {
            _topChild = param1;
         }
      }
      
      public function addChilds(param1:Vector.<DisplayObject>) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            addChild(param1[_loc3_]);
            _loc3_++;
         }
      }
      
      public function swapChildToTop(param1:DisplayObject) : void
      {
         if(_topChild != null && _parent == param1.parent)
         {
            _parent.swapChildren(param1,_topChild);
            _topChild = param1;
         }
      }
   }
}
