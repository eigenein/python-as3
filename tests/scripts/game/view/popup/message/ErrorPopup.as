package game.view.popup.message
{
   import com.progrestar.common.lang.Translate;
   import engine.context.GameContext;
   import feathers.core.PopUpManager;
   import game.assets.storage.AssetStorage;
   import game.view.popup.MessagePopup;
   
   public class ErrorPopup extends MessagePopup
   {
       
      
      private var critical:Boolean;
      
      public function ErrorPopup(param1:String, param2:String, param3:Boolean = false)
      {
         if(param2 == null)
         {
            param2 = Translate.translate("UI_POPUP_ERROR_HEADER");
         }
         super(param1,param2);
         this.critical = param3;
      }
      
      override public function close() : void
      {
         if(!critical || GameContext.instance.consoleEnabled)
         {
            super.close();
         }
      }
      
      override protected function handler_close() : void
      {
         if(critical)
         {
            GameContext.instance.reloadGame();
         }
         else
         {
            PopUpManager.removePopUp(this);
            dispose();
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         if(critical)
         {
            clip.button_ok.label = Translate.translate("UI_POPUP_ERROR_RELOAD");
         }
      }
      
      override protected function createClip() : MessagePopupClip
      {
         var _loc1_:MessagePopupClip = AssetStorage.rsx.popup_theme.create(MessagePopupClip,"popup_error");
         return _loc1_;
      }
   }
}
