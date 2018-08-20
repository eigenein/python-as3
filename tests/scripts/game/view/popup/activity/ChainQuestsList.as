package game.view.popup.activity
{
   import feathers.layout.TiledRowsLayout;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import starling.display.DisplayObject;
   
   public class ChainQuestsList extends GameScrolledList
   {
       
      
      public function ChainQuestsList(param1:GameScrollBar, param2:DisplayObject, param3:DisplayObject)
      {
         super(param1,param2,param3);
      }
      
      override protected function createLayout() : void
      {
         var _loc1_:TiledRowsLayout = new TiledRowsLayout();
         _loc1_.useSquareTiles = false;
         layout = _loc1_;
         _loc1_.gap = -4;
         _loc1_.horizontalGap = -4;
      }
   }
}
