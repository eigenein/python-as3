package game.mediator.gui.popup.mail
{
   import engine.context.GameContext;
   import engine.context.platform.social.socialQuest.SocialQuestHelper;
   import engine.core.assets.file.ImageFile;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.mail.PlayerMailEntry;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.mail.PlayerMailImportantPopup;
   
   public class PlayerMailImportantPopupMediator extends PopupMediator
   {
       
      
      private var _letter:PlayerMailEntry;
      
      private var _imageFile:ImageFile;
      
      private var _timeout_close:int;
      
      private var _message:String;
      
      private var _url:String;
      
      public function PlayerMailImportantPopupMediator(param1:Player, param2:PlayerMailEntry = null)
      {
         var _loc7_:* = undefined;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:* = null;
         _loc6_ = 0;
         super(param1);
         if(param2 == null)
         {
            _loc7_ = param1.mail.getList();
            _loc5_ = _loc7_.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               param2 = _loc7_[_loc6_];
               if(param2.type == "massImportant")
               {
                  this._letter = param2;
                  break;
               }
               _loc6_++;
            }
         }
         else
         {
            this._letter = param2;
         }
         var _loc4_:String = "";
         if(this._letter.params)
         {
            _loc4_ = this._letter.params.imgName;
         }
         if(_loc4_)
         {
            _loc4_ = _loc4_.replace("%locale%",GameContext.instance.localeID);
            _imageFile = GameContext.instance.assetIndex.getAssetFile(_loc4_) as ImageFile;
         }
         if(!_imageFile)
         {
            _loc4_ = "update_generic_%locale%.jpg";
            _loc4_ = _loc4_.replace("%locale%",GameContext.instance.localeID);
            _imageFile = GameContext.instance.assetIndex.getAssetFile(_loc4_) as ImageFile;
         }
         _timeout_close = 3000;
         if(param2.message.indexOf("http") != -1)
         {
            _loc3_ = param2.message.split("\n");
            _loc6_ = 0;
            while(_loc6_ < _loc3_.length)
            {
               if(_loc3_[_loc6_].indexOf("http") != -1)
               {
                  _url = _loc3_.splice(_loc6_,1);
                  break;
               }
               _loc6_++;
            }
            _message = _loc3_.join("\n");
         }
         else
         {
            _message = param2.message;
         }
      }
      
      public function get letter() : PlayerMailEntry
      {
         return _letter;
      }
      
      public function get imageFile() : ImageFile
      {
         return _imageFile;
      }
      
      public function get timeout_close() : int
      {
         return _timeout_close;
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new PlayerMailImportantPopup(this);
         return _popup;
      }
      
      public function action_ok() : void
      {
         GameModel.instance.actionManager.mail.mailFarm(_letter);
         close();
      }
      
      public function action_group() : void
      {
         Stash.click("group",_popup.stashParams);
         SocialQuestHelper.instance.actionHelp_navigateToGroupURL();
         GameModel.instance.actionManager.mail.mailFarm(_letter);
         close();
      }
      
      public function action_click() : void
      {
         Stash.click("url",_popup.stashParams);
         navigateToURL(new URLRequest(url),"_blank");
         GameModel.instance.actionManager.mail.mailFarm(_letter);
         close();
      }
   }
}
