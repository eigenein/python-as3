package game.view.specialoffer
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.model.user.specialoffer.PlayerSpecialOfferWithTimer;
   import game.model.user.specialoffer.SpecialOfferViewSlotEntry;
   import game.view.gui.components.ClipLabel;
   import game.view.specialoffer.welcomeback.ClipLabelInContainer;
   
   public class SpecialOfferTextView extends SpecialOfferViewClipBase
   {
       
      
      public var tf_text:ClipLabel;
      
      public var tf_text_container:ClipLabelInContainer;
      
      public var tf_time:ClipLabel;
      
      public function SpecialOfferTextView(param1:PlayerSpecialOfferWithTimer, param2:SpecialOfferViewSlotEntry)
      {
         tf_text = new ClipLabel();
         tf_text_container = new ClipLabelInContainer();
         tf_time = new ClipLabel();
         super(param1,param2);
         var _loc3_:RsxGuiAsset = AssetStorage.rsx.getByName(param2.assetIdent) as RsxGuiAsset;
         AssetStorage.instance.globalLoader.requestAssetWithCallback(_loc3_,handler_assetLoaded);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         AssetStorage.instance.globalLoader.cancelCallback(handler_assetLoaded);
      }
      
      protected function getText() : String
      {
         var _loc1_:* = null;
         if(_entry.params.localTitleKey)
         {
            if(_entry.params.text)
            {
               return Translate.translateArgs(_entry.params.localTitleKey,_entry.params.text);
            }
            if(_entry.params.arguments)
            {
               _loc1_ = _entry.params.arguments.concat();
               _loc1_.unshift(_entry.params.localTitleKey);
               return Translate.translateArgs.apply(this,_loc1_);
            }
            return Translate.translate(_entry.params.localTitleKey);
         }
         return _entry.params.text;
      }
      
      private function handler_assetLoaded(param1:RsxGuiAsset) : void
      {
         param1.initGuiClip(this,_entry.assetClip);
         var _loc2_:String = this.getText();
         tf_text.text = _loc2_;
         tf_text_container.text = _loc2_;
         handler_updated();
      }
      
      override protected function handler_updated() : void
      {
         tf_time.text = _offer.timerStringConstrained;
      }
   }
}
