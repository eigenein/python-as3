package game.view.specialoffer
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.model.user.specialoffer.PlayerSpecialOfferWithTimer;
   import game.model.user.specialoffer.SpecialOfferViewSlotEntry;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.specialoffer.welcomeback.ClipLabelInContainer;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class SpecialOfferSaleIconView extends SpecialOfferViewClipBase
   {
       
      
      public var tf_text:ClipLabel;
      
      public var tf_sale:SpecialClipLabel;
      
      public var tf_sale_value:SpecialClipLabel;
      
      public var tf_sale_container:ClipLabelInContainer;
      
      public var tf_time:ClipLabel;
      
      public var layout:ClipLayout;
      
      public function SpecialOfferSaleIconView(param1:PlayerSpecialOfferWithTimer, param2:SpecialOfferViewSlotEntry)
      {
         tf_text = new ClipLabel();
         tf_sale = new SpecialClipLabel();
         tf_sale_value = new SpecialClipLabel();
         tf_sale_container = new ClipLabelInContainer();
         tf_time = new ClipLabel();
         layout = ClipLayout.verticalMiddleCenter(2,tf_text,tf_time);
         super(param1,param2);
         graphics.touchable = false;
         var _loc3_:RsxGuiAsset = AssetStorage.rsx.getByName(param2.assetIdent) as RsxGuiAsset;
         AssetStorage.instance.globalLoader.requestAssetWithCallback(_loc3_,handler_assetLoaded);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         AssetStorage.instance.globalLoader.cancelCallback(handler_assetLoaded);
      }
      
      protected function get localeSaleValue() : String
      {
         return _entry.params.discount;
      }
      
      protected function get localeSaleString() : String
      {
         var _loc1_:String = ColorUtils.hexToRGBFormat(16776960);
         var _loc2_:String = ColorUtils.hexToRGBFormat(16449533);
         return Translate.translateArgs(_entry.params.localeSaleKey,_loc1_ + localeSaleValue + _loc2_);
      }
      
      private function handler_assetLoaded(param1:RsxGuiAsset) : void
      {
         param1.initGuiClip(this,_entry.assetClip);
         tf_text.text = Translate.translate(_entry.params.localeTitleKey);
         tf_sale.text = localeSaleString;
         tf_sale_value.text = "-" + localeSaleValue;
         tf_sale_container.text = "-" + localeSaleValue;
         handler_updated();
      }
      
      override protected function handler_updated() : void
      {
         tf_time.text = _offer.timerStringConstrained;
      }
   }
}
