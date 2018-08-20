package game.model.user.social
{
   import flash.external.ExternalInterface;
   import game.data.storage.pve.mission.MissionDescription;
   import game.mediator.gui.popup.PopupList;
   import game.model.user.Player;
   import game.view.popup.MessagePopup;
   import idv.cjcat.signals.Signal;
   
   public class GMRUserAgreementCheck
   {
      
      private static var _instance:GMRUserAgreementCheck;
       
      
      public const mission_index:int = 5;
      
      private var status:Boolean;
      
      public const signal_userAgreementStatus:Signal = new Signal(Boolean);
      
      public function GMRUserAgreementCheck(param1:Player)
      {
         var _loc2_:* = null;
         super();
         _instance = this;
         if(param1.missions.currentMission)
         {
            _loc2_ = param1.missions.currentMission.desc;
            if(_loc2_.world == 1 && _loc2_.index > 5 || _loc2_.world > 1)
            {
               action_userAgreementShow();
            }
         }
      }
      
      public static function get instance() : GMRUserAgreementCheck
      {
         return _instance;
      }
      
      public function action_userAgreementShow() : void
      {
         if(!status)
         {
            ExternalInterface.call("window.GMRExternalApi.userConfirm");
            ExternalInterface.addCallback("userConfirmCallback",gmr_callback);
         }
      }
      
      private function gmr_callback(param1:Object) : void
      {
         try
         {
            if(param1.status == "ok")
            {
               status = true;
               signal_userAgreementStatus.dispatch(true);
               return;
            }
            PopupList.instance.message("UI_GMR_EULA_ACCEPT").signal_okClose.add(handler_ingamePopupOK);
         }
         catch(error:Error)
         {
         }
         signal_userAgreementStatus.dispatch(false);
      }
      
      private function handler_ingamePopupOK(param1:MessagePopup) : void
      {
         action_userAgreementShow();
      }
   }
}
