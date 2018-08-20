package feathers.utils.display
{
   import starling.display.DisplayObject;
   
   public function getDisplayObjectDepthFromStage(param1:DisplayObject) : int
   {
      if(!param1.stage)
      {
         return -1;
      }
      var _loc2_:int = 0;
      while(param1.parent)
      {
         param1 = param1.parent;
         _loc2_++;
      }
      return _loc2_;
   }
}
