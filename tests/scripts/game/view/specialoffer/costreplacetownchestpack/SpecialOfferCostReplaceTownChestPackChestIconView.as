package game.view.specialoffer.costreplacetownchestpack
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.model.user.specialoffer.PlayerSpecialOfferCostReplaceTownChestPack;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.reward.GuiElementExternalStyle;
   import game.view.specialoffer.welcomeback.ClipLabelInContainer;
   
   public class SpecialOfferCostReplaceTownChestPackChestIconView extends GuiClipNestedContainer
   {
       
      
      private var offer:PlayerSpecialOfferCostReplaceTownChestPack;
      
      public const displayStyle:GuiElementExternalStyle = new GuiElementExternalStyle();
      
      public var tf_text:ClipLabel;
      
      public var tf_sale:SpecialClipLabel;
      
      public var tf_sale_container:ClipLabelInContainer;
      
      public var tf_time:ClipLabel;
      
      public var layout:ClipLayout;
      
      public function SpecialOfferCostReplaceTownChestPackChestIconView(param1:PlayerSpecialOfferCostReplaceTownChestPack, param2:String)
      {
         tf_text = new ClipLabel();
         tf_sale = new SpecialClipLabel();
         tf_sale_container = new ClipLabelInContainer();
         tf_time = new ClipLabel();
         layout = ClipLayout.verticalMiddleCenter(2);
         super();
         this.offer = param1;
         graphics.touchable = false;
         var _loc3_:RsxGuiAsset = AssetStorage.rsx.getByName(param1.assetIdent) as RsxGuiAsset;
         _loc3_.initGuiClip(this,param2);
         tf_text.text = Translate.translate(param1.localeTitleKey);
         tf_sale.text = param1.localeSale;
         tf_sale_container.text = "-" + param1.saleDiscountString;
         if(layout.width != 0)
         {
            layout.addChild(tf_text);
            layout.addChild(tf_time);
         }
         handler_updated();
         param1.signal_updated.add(handler_updated);
         param1.signal_removed.add(handler_removed);
         displayStyle.signal_dispose.add(dispose);
      }
      
      public function dispose() : void
      {
         displayStyle.signal_dispose.remove(dispose);
         graphics.removeFromParent(true);
         offer.signal_updated.remove(handler_updated);
         offer.signal_removed.remove(handler_removed);
      }
      
      protected function handler_updated() : void
      {
         tf_time.text = offer.timerStringConstrained;
      }
      
      protected function handler_removed() : void
      {
         displayStyle.dispose();
      }
   }
}
