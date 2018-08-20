package game.view.popup.test.battlelist
{
   import feathers.layout.TiledColumnsLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.view.gui.components.toggle.ClipToggleButton;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   import starling.events.Event;
   
   public class BattleTestListPopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var mediator:BattleTestListPopupMediator;
      
      private var clip:BattleTestListPopupClip;
      
      public function BattleTestListPopup(param1:BattleTestListPopupMediator)
      {
         super(param1,AssetStorage.rsx.dialog_test_battle);
         this.mediator = param1;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         clip = param1.create(BattleTestListPopupClip,"dialog_test_battle_list");
         addChild(clip.graphics);
         centerPopupBy(clip.frame.graphics);
         clip.button_start.initialize("Начать",handler_start,false);
         mediator.inProgress.onValue(clip.button_start.setIsSelectedSilently);
         clip.list.dataProvider = mediator.list;
         clip.list.itemRendererFactory = factory_listItem;
         var _loc2_:TiledColumnsLayout = new TiledColumnsLayout();
         _loc2_.useSquareTiles = false;
         _loc2_.horizontalGap = 10;
         _loc2_.verticalGap = 0;
         _loc2_.horizontalAlign = "left";
         clip.list.layout = _loc2_;
         clip.button_close.signal_click.add(mediator.close);
         addEventListener("enterFrame",handler_enterFrame);
      }
      
      private function factory_listItem() : *
      {
         var _loc1_:BattleTestListItemClip = new BattleTestListItemClip();
         clip.list_item.create(_loc1_);
         return new BattleTestListItemRenderer(_loc1_);
      }
      
      private function handler_enterFrame(param1:Event) : void
      {
         mediator.action_enterFrame();
      }
      
      private function handler_start(param1:ClipToggleButton) : void
      {
         mediator.action_start(true);
      }
   }
}
