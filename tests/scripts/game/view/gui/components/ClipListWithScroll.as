package game.view.gui.components
{
   import feathers.controls.List;
   import feathers.layout.VerticalLayout;
   import starling.display.DisplayObject;
   
   public class ClipListWithScroll extends ClipList
   {
       
      
      private var externalScroll:GameScrollBar;
      
      public function ClipListWithScroll(param1:*, param2:GameScrollBar, param3:* = null)
      {
         super(param1,param3);
         this.externalScroll = param2;
      }
      
      public function addGradients(param1:DisplayObject, param2:DisplayObject) : void
      {
         if(list)
         {
            (list as GameScrolledList).addGradients(param1,param2);
         }
      }
      
      override protected function listFactory() : List
      {
         var _loc2_:GameScrolledList = new GameScrolledList(externalScroll,null,null);
         var _loc1_:VerticalLayout = new VerticalLayout();
         _loc2_.layout = _loc1_;
         return _loc2_;
      }
   }
}
