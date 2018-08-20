package game.view.popup.player
{
   import feathers.layout.TiledRowsLayout;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import starling.display.DisplayObject;
   
   public class AvatarSelectList extends GameScrolledList
   {
       
      
      public function AvatarSelectList(param1:GameScrollBar, param2:DisplayObject, param3:DisplayObject)
      {
         super(param1,param2,param3);
         snapScrollPositionsToPixels = true;
      }
      
      override protected function createLayout() : void
      {
         var _loc1_:TiledRowsLayout = new TiledRowsLayout();
         _loc1_.gap = 8;
         itemRendererType = AvatarSelectListItem;
         layout = _loc1_;
         var _loc2_:int = 15;
         _loc1_.paddingBottom = _loc2_;
         _loc1_.paddingTop = _loc2_;
      }
   }
}
