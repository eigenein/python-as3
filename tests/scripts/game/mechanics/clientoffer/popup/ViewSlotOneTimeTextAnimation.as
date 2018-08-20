package game.mechanics.clientoffer.popup
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.ClipAnimatedContainer;
   import engine.core.clipgui.GuiAnimation;
   import feathers.controls.LayoutGroup;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.model.user.specialoffer.ISpecialOfferViewSlotObject;
   import game.model.user.specialoffer.viewslot.ViewSlotEntry;
   import game.view.popup.reward.GuiElementExternalStyle;
   import game.view.specialoffer.welcomeback.ClipLabelInContainer;
   
   public class ViewSlotOneTimeTextAnimation extends ClipAnimatedContainer implements ISpecialOfferViewSlotObject
   {
       
      
      protected var _entry:ViewSlotEntry;
      
      protected var _externalStyle:GuiElementExternalStyle;
      
      public const animation_front:GuiAnimation = new GuiAnimation();
      
      public const animation_back:GuiAnimation = new GuiAnimation();
      
      public const tf_text:ClipLabelInContainer = new ClipLabelInContainer();
      
      public function ViewSlotOneTimeTextAnimation(param1:ViewSlotEntry)
      {
         _container = new LayoutGroup();
         _container.width = 0;
         _container.height = 0;
         super();
         _entry = param1;
         _externalStyle = new GuiElementExternalStyle();
         _externalStyle.setNextAbove(graphics,_entry.createAlignment());
         _externalStyle.signal_dispose.add(dispose);
         var _loc2_:RsxGuiAsset = AssetStorage.rsx.getByName(param1.assetIdent) as RsxGuiAsset;
         AssetStorage.instance.globalLoader.requestAssetWithCallback(_loc2_,handler_assetLoaded);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         AssetStorage.instance.globalLoader.cancelCallback(handler_assetLoaded);
      }
      
      public function get externalStyle() : GuiElementExternalStyle
      {
         return _externalStyle;
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
         animation_front.playOnce();
         animation_back.playOnce();
         playback.playOnce();
         var _loc2_:String = this.getText();
         tf_text.text = _loc2_;
         graphics.dispatchEventWith("resize");
         _externalStyle.realign();
      }
   }
}
