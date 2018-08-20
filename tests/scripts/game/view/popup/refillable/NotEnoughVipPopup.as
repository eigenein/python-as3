package game.view.popup.refillable
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.PopupList;
   import game.stat.Stash;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.ClipBasedPopup;
   
   public class NotEnoughVipPopup extends ClipBasedPopup implements ITutorialActionProvider
   {
       
      
      private var clip:NotEnoughVipPopupClip;
      
      private var level:int;
      
      private var message:String;
      
      public function NotEnoughVipPopup(param1:String, param2:int)
      {
         super(null);
         this.message = param1;
         this.level = param2;
         stashParams.windowName = "NotEnoughVipPopup";
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         _loc2_.addCloseButton(clip.button_ok);
         return _loc2_;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(NotEnoughVipPopupClip,"popup_not_enough_vip_level") as NotEnoughVipPopupClip;
         addChild(clip.graphics);
         clip.tf_header.text = Translate.translate("UI_POPUP_NOT_ENOUGH_VIP");
         clip.tf_message.text = message;
         clip.button_ok.label = Translate.translate("U_POPUP_STAMINA_REFILL_BANK");
         clip.button_ok.signal_click.add(action_bank);
         clip.button_close.signal_click.add(close);
         clip.next_vip_level.setVip(level);
         clip.layout_text.validate();
         clip.bg.graphics.height = clip.layout_text.graphics.y + clip.layout_text.graphics.height + 20;
      }
      
      private function action_bank() : void
      {
         close();
         PopupList.instance.dialog_bank(Stash.click("action_bank",stashParams));
      }
   }
}
