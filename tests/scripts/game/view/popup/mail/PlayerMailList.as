package game.view.popup.mail
{
   import feathers.layout.VerticalLayout;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import starling.display.DisplayObject;
   
   public class PlayerMailList extends GameScrolledList
   {
       
      
      public function PlayerMailList(param1:GameScrollBar, param2:DisplayObject, param3:DisplayObject)
      {
         super(param1,param2,param3);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         itemRendererType = PlayerMailListItemRenderer;
      }
      
      override protected function createLayout() : void
      {
         var _loc1_:VerticalLayout = new VerticalLayout();
         _loc1_.paddingTop = 20;
         _loc1_.paddingBottom = 10;
         _loc1_.gap = 5;
         layout = _loc1_;
      }
   }
}
