package game.view.popup.ny.gifts
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.ClipAnimatedContainer;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.ny.NewYearGiftData;
   import game.util.DateFormatter;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.components.tooltip.TooltipTextView;
   
   public class NYSendedGiftRenderer extends ListItemRenderer
   {
       
      
      private var giftData:NewYearGiftData;
      
      private var tooltipVO:TooltipVO;
      
      private var clip:NYSendedGiftRendererClip;
      
      private var giftAnimationView:UserNYGiftAnimationView;
      
      private var dropAnimation:ClipAnimatedContainer;
      
      public function NYSendedGiftRenderer()
      {
         super();
      }
      
      override public function dispose() : void
      {
         TooltipHelper.removeTooltip(clip.tf_title);
         super.dispose();
      }
      
      override public function set data(param1:Object) : void
      {
         if(giftData == param1)
         {
            return;
         }
         giftData = param1 as NewYearGiftData;
         .super.data = param1;
      }
      
      public function get tooltipText() : String
      {
         var _loc1_:String = null;
         if(giftData && giftData.to)
         {
            _loc1_ = "ID: " + giftData.to.id;
            if(giftData.to.clanInfo)
            {
               _loc1_ = _loc1_ + ("\n" + giftData.to.clanInfo.title);
            }
         }
         return _loc1_;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.ny_gifts.create(NYSendedGiftRendererClip,"ny_sended_gift_renderer");
         addChild(clip.container);
         width = clip.bg.graphics.width;
         height = clip.bg.graphics.height;
         invalidate("data");
      }
      
      override protected function draw() : void
      {
         var _loc1_:* = null;
         super.draw();
         if(isInvalid("data") && clip)
         {
            TooltipHelper.removeTooltip(clip.tf_title);
            if(giftData)
            {
               TooltipHelper.addTooltip(clip.tf_title,new TooltipVO(TooltipTextView,tooltipText));
               clip.gift_container.container.removeChildren();
               giftAnimationView = AssetStorage.rsx.ny_gifts.create(UserNYGiftAnimationView,"user_" + giftData.desc.asset);
               giftAnimationView.graphics.touchable = false;
               giftAnimationView.giftOpened = giftData.opened;
               clip.gift_container.container.addChild(giftAnimationView.graphics);
               clip.tf_title.text = Translate.translateArgs("UI_DIALOG_NY_GIFTS_TO",giftData.to.nickname);
               _loc1_ = new Date(giftData.ctime * 1000);
               clip.tf_time.text = DateFormatter.dateToDDMMYYYY(_loc1_) + " " + DateFormatter.dateToHHMM(_loc1_);
               updateState(false);
            }
         }
      }
      
      private function updateState(param1:Boolean) : void
      {
      }
   }
}
