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
   import idv.cjcat.signals.Signal;
   
   public class NYReceivedGiftRenderer extends ListItemRenderer
   {
       
      
      private var giftData:NewYearGiftData;
      
      private var tooltipVO:TooltipVO;
      
      private var dropContainerY:Number;
      
      private var clip:NYReceivedGiftRendererClip;
      
      private var giftAnimationView:UserNYGiftAnimationView;
      
      private var animation:ClipAnimatedContainer;
      
      public var signal_giftOpen:Signal;
      
      public var signal_send:Signal;
      
      public function NYReceivedGiftRenderer()
      {
         signal_giftOpen = new Signal(NewYearGiftData);
         signal_send = new Signal(NewYearGiftData);
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
         if(giftData)
         {
            giftData.signal_giftOpenedChange.remove(handler_giftOpenedChange);
            giftData.signal_giftReplayGiftIdChange.remove(handler_giftReplayGiftIdChange);
         }
         giftData = param1 as NewYearGiftData;
         if(giftData)
         {
            giftData.signal_giftOpenedChange.add(handler_giftOpenedChange);
            giftData.signal_giftReplayGiftIdChange.add(handler_giftReplayGiftIdChange);
         }
         .super.data = param1;
      }
      
      public function get tooltipText() : String
      {
         var _loc1_:String = null;
         if(giftData && giftData.from)
         {
            _loc1_ = "ID: " + giftData.from.id;
            if(giftData.from.clanInfo)
            {
               _loc1_ = _loc1_ + ("\n" + giftData.from.clanInfo.title);
            }
         }
         return _loc1_;
      }
      
      public function get replyAvaliable() : Boolean
      {
         return giftData.opened && !giftData.senderIsWendy && !giftData.hasReplyGift && !giftData.fromMe && !giftData.senderIsWiped;
      }
      
      public function get giftSent() : Boolean
      {
         return giftData.opened && giftData.hasReplyGift && !giftData.senderIsWendy;
      }
      
      public function get giftOpened() : Boolean
      {
         return giftData.opened;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.ny_gifts.create(NYReceivedGiftRendererClip,"ny_received_gift_renderer");
         addChild(clip.container);
         dropContainerY = clip.drop_container.container.y;
         clip.info_content.btn_send.signal_click.add(handler_send);
         clip.tf_gift_sent.text = Translate.translate("UI_DIALOG_NY_GIFTS_HAS_REPLAY");
         clip.info_content.tf_send.text = Translate.translate("UI_DIALOG_NY_GIFTS_SEND_IN_RESPONSE");
         clip.btn_open.label = Translate.translate("UI_DIALOG_NY_GIFTS_OPEN");
         clip.btn_open.signal_click.add(handler_giftOpen);
         width = 405;
         height = 200;
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
               if(!giftData.senderIsWendy)
               {
                  TooltipHelper.addTooltip(clip.tf_title,new TooltipVO(TooltipTextView,tooltipText));
               }
               if(giftAnimationView)
               {
                  giftAnimationView.graphics.removeFromParent();
                  giftAnimationView.signal_click.remove(handler_giftOpen);
               }
               giftAnimationView = AssetStorage.rsx.ny_gifts.create(UserNYGiftAnimationView,"user_" + giftData.desc.asset);
               giftAnimationView.signal_click.add(handler_giftOpen);
               giftAnimationView.giftOpened = giftData.opened;
               clip.gift_container.container.addChild(giftAnimationView.graphics);
               clip.tf_title.text = Translate.translateArgs("UI_DIALOG_NY_GIFTS_FROM",giftData.from.nickname);
               _loc1_ = new Date(giftData.ctime * 1000);
               clip.tf_time.text = DateFormatter.dateToDDMMYYYY(_loc1_) + " " + DateFormatter.dateToHHMM(_loc1_);
               clip.info_content.btn_send.cost = giftData.desc.cost.outputDisplayFirst;
               updateState(false);
            }
         }
      }
      
      private function updateState(param1:Boolean) : void
      {
         clip.btn_open.graphics.visible = !giftOpened;
         clip.info_content.graphics.visible = replyAvaliable;
         clip.layout_gift_sent.visible = giftSent;
         clip.layout_reason.visible = false;
         if(replyAvaliable || giftSent)
         {
            clip.drop_container.container.y = dropContainerY - 35;
         }
         else
         {
            clip.drop_container.container.y = dropContainerY;
         }
         if(animation)
         {
            animation.container.removeFromParent(true);
            animation = null;
         }
         if(giftData.opened && giftData.reward.outputDisplay.length)
         {
            switch(int(giftData.reward.outputDisplay.length) - 1)
            {
               case 0:
                  animation = AssetStorage.rsx.ny_gifts.create(NYReceive1ItemsAnimation,"gift_drop_anim_1");
                  (animation as NYReceive1ItemsAnimation).item1.setData(giftData.reward.outputDisplay[0]);
                  clip.drop_container.container.addChild(animation.graphics);
                  break;
               case 1:
                  animation = AssetStorage.rsx.ny_gifts.create(NYReceive2ItemsAnimation,"gift_drop_anim_2");
                  (animation as NYReceive2ItemsAnimation).item1.setData(giftData.reward.outputDisplay[0]);
                  (animation as NYReceive2ItemsAnimation).item2.setData(giftData.reward.outputDisplay[1]);
                  clip.drop_container.container.addChild(animation.graphics);
                  break;
               case 2:
                  animation = AssetStorage.rsx.ny_gifts.create(NYReceive3ItemsAnimation,"gift_drop_anim_3");
                  (animation as NYReceive3ItemsAnimation).item1.setData(giftData.reward.outputDisplay[0]);
                  (animation as NYReceive3ItemsAnimation).item2.setData(giftData.reward.outputDisplay[1]);
                  (animation as NYReceive3ItemsAnimation).item3.setData(giftData.reward.outputDisplay[2]);
                  clip.drop_container.container.addChild(animation.graphics);
            }
            if(animation)
            {
               if(!param1)
               {
                  animation.playback.gotoAndStop(animation.playback.lastFrame);
               }
               else
               {
                  animation.playback.playOnce();
               }
            }
            if(giftData.reason_isDaily)
            {
               clip.layout_reason.visible = true;
               clip.tf_reason.text = Translate.translate("UI_NY_RECEIVED_GIFT_RENDERER_REASON_DAILY");
            }
            else if(giftData.reason_isTreeLevel)
            {
               clip.layout_reason.visible = true;
               clip.tf_reason.text = Translate.translateArgs("UI_NY_RECEIVED_GIFT_RENDERER_REASON_LEVEL_UP",giftData.treeLevel);
            }
            else
            {
               clip.layout_reason.visible = false;
            }
            if(giftAnimationView && param1)
            {
               giftAnimationView.playOpenAnimation();
            }
         }
      }
      
      private function handler_giftOpen() : void
      {
         signal_giftOpen.dispatch(data as NewYearGiftData);
      }
      
      private function handler_send() : void
      {
         signal_send.dispatch(data as NewYearGiftData);
      }
      
      private function handler_giftOpenedChange() : void
      {
         updateState(true);
      }
      
      private function handler_giftReplayGiftIdChange() : void
      {
         updateState(false);
      }
   }
}
