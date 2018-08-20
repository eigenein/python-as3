package game.mechanics.expedition.popup
{
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.expedition.mediator.ExpeditionListPopupMediator;
   import game.mechanics.expedition.mediator.ExpeditionValueObject;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   
   public class ExpeditionListPopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var clip:ExpeditionListPopupClip;
      
      private var mediator:ExpeditionListPopupMediator;
      
      public function ExpeditionListPopup(param1:ExpeditionListPopupMediator)
      {
         this.mediator = param1;
         super(param1,AssetStorage.rsx.dialog_expedition);
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         clip = param1.create(ExpeditionListPopupClip,"dialog_expedition_list");
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         mediator.signal_updateAll.add(handler_updateAll);
         updateExpeditions();
      }
      
      protected function updateExpeditions() : void
      {
         var _loc2_:* = 0;
         var _loc3_:Vector.<ExpeditionValueObject> = mediator.getExpeditions();
         var _loc4_:int = clip.item.length;
         var _loc1_:int = Math.min(_loc3_.length,_loc4_);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            clip.item[_loc2_].setData(_loc3_[_loc2_]);
            _loc2_++;
         }
         _loc2_ = _loc1_;
         while(_loc2_ < _loc4_)
         {
            clip.item[_loc2_].setData(null);
            _loc2_++;
         }
      }
      
      private function handler_updateAll() : void
      {
         updateExpeditions();
      }
   }
}
