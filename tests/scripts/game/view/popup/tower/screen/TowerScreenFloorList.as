package game.view.popup.tower.screen
{
   import feathers.controls.List;
   
   public class TowerScreenFloorList extends List
   {
       
      
      private var _lastIndex:int = -1;
      
      public function TowerScreenFloorList()
      {
         super();
      }
      
      public function get lastIndex() : int
      {
         return _lastIndex;
      }
      
      override public function scrollToDisplayIndex(param1:int, param2:Number = 0) : void
      {
         super.scrollToDisplayIndex(param1,param2);
         _lastIndex = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
      }
   }
}
