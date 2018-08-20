package game.mechanics.expedition.popup
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.command.timer.GameTimer;
   import game.mechanics.expedition.mediator.ExpeditionMapPopupMediator;
   import game.mechanics.expedition.mediator.ExpeditionValueObject;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   
   public class ExpeditionMapPopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var clip:ExpeditionMapPopupClip;
      
      private var mediator:ExpeditionMapPopupMediator;
      
      public function ExpeditionMapPopup(param1:ExpeditionMapPopupMediator)
      {
         this.mediator = param1;
         super(param1,AssetStorage.rsx.dialog_expedition);
      }
      
      override public function dispose() : void
      {
         GameTimer.instance.oneSecTimer.remove(handler_oneSecTimer);
         super.dispose();
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         var _loc3_:int = 0;
         clip = param1.create(ExpeditionMapPopupClip,"dialog_expedition_map");
         width = clip.map_image.graphics.width;
         height = clip.map_image.graphics.height;
         clip.tf_title.text = Translate.translate("UI_DIALOG_EXPEDITION_MAP_TF_TITLE");
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         mediator.signal_updateAll.add(handler_updateAll);
         var _loc2_:int = clip.item.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            clip.item[_loc3_].signal_click.add(mediator.action_select);
            _loc3_++;
         }
         GameTimer.instance.oneSecTimer.add(handler_oneSecTimer);
         handler_oneSecTimer();
         updateExpeditions();
      }
      
      protected function updateExpeditions() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:Vector.<ExpeditionValueObject> = mediator.getExpeditions();
         var _loc5_:int = clip.item.length;
         var _loc1_:int = Math.min(_loc4_.length,_loc5_);
         _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            clip.item[_loc2_].setData(null);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = _loc4_[_loc2_].entry.slotId - 1;
            clip.item[_loc3_].setData(_loc4_[_loc2_]);
            _loc6_ = _loc4_[_loc2_].entry.storyId - 1;
            clip.item[_loc3_].graphics.x = clip.story_position[_loc6_].graphics.x;
            clip.item[_loc3_].graphics.y = clip.story_position[_loc6_].graphics.y;
            _loc2_++;
         }
      }
      
      private function handler_updateAll() : void
      {
         updateExpeditions();
      }
      
      private function handler_oneSecTimer() : void
      {
         clip.tf_status.text = Translate.translateArgs("UI_DIALOG_EXPEDITION_MAP_TF_STATUS",mediator.timer_moreExpeditionsIn);
      }
   }
}
