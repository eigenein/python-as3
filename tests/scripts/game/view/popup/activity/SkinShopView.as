package game.view.popup.activity
{
   import com.progrestar.common.lang.Translate;
   import feathers.controls.LayoutGroup;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.view.gui.components.GameLabel;
   import game.view.popup.theme.LabelStyle;
   
   public class SkinShopView extends LayoutGroup
   {
       
      
      private var clip:SkinShopViewClip;
      
      private var mediator:SkinShopMediator;
      
      private var stashParams:PopupStashEventParams;
      
      public function SkinShopView(param1:SkinShopMediator, param2:PopupStashEventParams)
      {
         super();
         this.mediator = param1;
         this.stashParams = param2;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_view_skin_shop();
         addChild(clip.graphics);
         _loc2_ = 0;
         while(_loc2_ < clip.renderer.length)
         {
            clip.renderer[_loc2_].container.removeFromParent();
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < mediator.billingList.length)
         {
            clip.layout_content.addChild(clip.renderer[_loc2_].container);
            _loc2_++;
         }
         clip.layout_content.validate();
         _loc2_ = 0;
         while(_loc2_ < mediator.billingList.length)
         {
            clip.renderer[_loc2_].setData(mediator.billingList[_loc2_],mediator);
            _loc2_++;
         }
         if(clip.layout_content.numChildren == 0)
         {
            _loc1_ = LabelStyle.createLabel(16,16770485,"center",true);
            _loc1_.width = 460;
            _loc1_.text = Translate.translate("UI_TRIPLE_SKI_BUNDLE_LIST_EMPTY");
            clip.layout_content.addChild(_loc1_);
         }
         clip.tf_label_timer.text = Translate.translate("UI_POPUP_BUNDLE_TIMER");
         clip.tf_header.text = mediator.headerText;
         mediator.signal_updateTime.add(handler_updateTimer);
         handler_updateTimer();
      }
      
      protected function handler_updateTimer() : void
      {
         if(clip && mediator)
         {
            clip.tf_timer.text = mediator.timeLeftString;
         }
      }
   }
}
