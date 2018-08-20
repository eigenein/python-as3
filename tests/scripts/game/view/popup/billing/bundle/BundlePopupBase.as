package game.view.popup.billing.bundle
{
   import com.progrestar.common.lang.Translate;
   import game.mediator.gui.popup.billing.bundle.BundlePopupMediator;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   import game.view.popup.common.PopupSideBar;
   
   public class BundlePopupBase extends ClipBasedPopup implements IEscClosable
   {
       
      
      protected var __mediator:BundlePopupMediator;
      
      protected var sideBar:PopupSideBar;
      
      protected var timerBlock:BundlePopupTimerBlockClip;
      
      public function BundlePopupBase(param1:BundlePopupMediator)
      {
         super(param1);
         this.__mediator = param1;
         stashParams.windowName = "bundle:" + param1.bundleId;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(sideBar)
         {
            sideBar.dispose();
         }
         __mediator.signal_updateBundleTimeLeft.remove(handler_updateTimer);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         __mediator.action_notifyShown();
         sideBar = new PopupSideBar(this,__mediator.sideBarMediator);
         addChild(sideBar.graphics);
      }
      
      protected function initTimer(param1:BundlePopupTimerBlockClip, param2:Boolean = false) : void
      {
         this.timerBlock = param1;
         param1.tf_label_timer.text = Translate.translate("UI_POPUP_BUNDLE_TIMER");
         var _loc3_:Boolean = __mediator.hasTimer && !param2;
         param1.graphics.visible = _loc3_;
         if(_loc3_)
         {
            __mediator.signal_updateBundleTimeLeft.add(handler_updateTimer);
            handler_updateTimer();
         }
      }
      
      protected function handler_updateTimer() : void
      {
         timerBlock.tf_timer.text = __mediator.bundleTimeLeft;
      }
   }
}
