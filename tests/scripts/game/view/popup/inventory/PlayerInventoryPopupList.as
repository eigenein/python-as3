package game.view.popup.inventory
{
   import feathers.layout.TiledRowsLayout;
   import game.mediator.gui.popup.inventory.PlayerInventoryPopupMediator;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import starling.display.DisplayObject;
   
   public class PlayerInventoryPopupList extends GameScrolledList
   {
       
      
      private var mediator:PlayerInventoryPopupMediator;
      
      public function PlayerInventoryPopupList(param1:PlayerInventoryPopupMediator, param2:GameScrollBar, param3:DisplayObject, param4:DisplayObject)
      {
         super(param2,param3,param4);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         itemRendererType = PlayerInventoryPopupItemRenderer;
      }
      
      override protected function createLayout() : void
      {
         var _loc1_:TiledRowsLayout = new TiledRowsLayout();
         layout = _loc1_;
         var _loc2_:int = 20;
         (layout as TiledRowsLayout).paddingBottom = _loc2_;
         _loc1_.paddingTop = _loc2_;
         _loc1_.gap = 0;
      }
   }
}
