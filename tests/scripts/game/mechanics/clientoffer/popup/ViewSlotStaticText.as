package game.mechanics.clientoffer.popup
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.model.user.specialoffer.ISpecialOfferViewSlotObject;
   import game.model.user.specialoffer.viewslot.ViewSlotEntry;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.reward.GuiElementExternalStyle;
   import game.view.specialoffer.welcomeback.ClipLabelInContainer;
   
   public class ViewSlotStaticText extends GuiClipNestedContainer implements ISpecialOfferViewSlotObject
   {
       
      
      protected var _entry:ViewSlotEntry;
      
      protected var _externalStyle:GuiElementExternalStyle;
      
      public var tf_text:ClipLabel;
      
      public var tf_text_container:ClipLabelInContainer;
      
      public var animation_one_time:Vector.<GuiAnimation>;
      
      public function ViewSlotStaticText(param1:ViewSlotEntry)
      {
         tf_text = new ClipLabel();
         tf_text_container = new ClipLabelInContainer();
         animation_one_time = new Vector.<GuiAnimation>();
         super();
         _entry = param1;
         var _loc2_:RsxGuiAsset = AssetStorage.rsx.getByName(param1.assetIdent) as RsxGuiAsset;
         AssetStorage.instance.globalLoader.requestAssetWithCallback(_loc2_,handler_assetLoaded);
         _externalStyle = new GuiElementExternalStyle();
         _externalStyle.setNextAbove(graphics,_entry.createAlignment());
         _externalStyle.signal_dispose.add(dispose);
      }
      
      public function dispose() : void
      {
         AssetStorage.instance.globalLoader.cancelCallback(handler_assetLoaded);
      }
      
      public function get externalStyle() : GuiElementExternalStyle
      {
         return _externalStyle;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc4_:int = 0;
         var _loc3_:* = animation_one_time;
         for each(var _loc2_ in animation_one_time)
         {
            _loc2_.playOnce();
         }
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
      }
   }
}
