package game.view.popup.selectaccount
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.command.rpc.player.server.ServerListUserValueObject;
   import game.data.storage.DataStorage;
   import game.data.storage.level.VIPLevel;
   import game.data.storage.playeravatar.PlayerAvatarDescription;
   import game.model.user.ClanUserInfoValueObject;
   import starling.textures.Texture;
   
   public class SelectAccountItemRendererMediator
   {
       
      
      private var _accountData:ServerListUserValueObject;
      
      public function SelectAccountItemRendererMediator()
      {
         super();
      }
      
      public function get accountData() : ServerListUserValueObject
      {
         return _accountData;
      }
      
      public function set accountData(param1:ServerListUserValueObject) : void
      {
         _accountData = param1;
      }
      
      public function get nickname() : String
      {
         if(!accountData)
         {
            return null;
         }
         return accountData.nickname;
      }
      
      public function get id() : String
      {
         if(!accountData)
         {
            return null;
         }
         return accountData.id;
      }
      
      public function get level() : int
      {
         if(!accountData)
         {
            return 0;
         }
         return accountData.level;
      }
      
      public function get vipLevel() : int
      {
         var _loc1_:* = null;
         if(accountData)
         {
            _loc1_ = DataStorage.level.getVipLevelByVipPoints(accountData.vipPoints);
            if(_loc1_)
            {
               return _loc1_.level;
            }
         }
         return 0;
      }
      
      public function get power() : int
      {
         if(accountData)
         {
            return accountData.power;
         }
         return 0;
      }
      
      public function get countHeroes() : int
      {
         if(accountData)
         {
            return accountData.countHeroes;
         }
         return 0;
      }
      
      public function get userClanID() : int
      {
         if(accountData && accountData.clanInfo)
         {
            return accountData.clanInfo.id;
         }
         return 0;
      }
      
      public function get userClanInfo() : ClanUserInfoValueObject
      {
         if(accountData)
         {
            return accountData.clanInfo;
         }
         return null;
      }
      
      public function get userAvatarDescription() : PlayerAvatarDescription
      {
         if(!accountData)
         {
            return null;
         }
         return DataStorage.playerAvatar.getAvatarById(accountData.avatarId);
      }
      
      public function get userAvatarTexture() : Texture
      {
         if(!accountData || !userAvatarDescription)
         {
            return AssetStorage.rsx.popup_theme.missing_texture;
         }
         return DataStorage.playerAvatar.getTexture(userAvatarDescription);
      }
      
      public function get userAvatarBackgroundTexture() : Texture
      {
         if(!accountData || !userAvatarDescription)
         {
            return AssetStorage.rsx.popup_theme.missing_texture;
         }
         return DataStorage.playerAvatar.getTextureBackground(userAvatarDescription);
      }
      
      public function get serverName() : String
      {
         if(accountData)
         {
            return Translate.translateArgs("UI_DIALOG_MERGE_SERVER",accountData.serverId) + ": " + Translate.translate("LIB_SERVER_NAME_" + accountData.serverId);
         }
         return null;
      }
      
      public function get clanName() : String
      {
         if(accountData && accountData.clanInfo)
         {
            return accountData.clanInfo.title;
         }
         return null;
      }
   }
}
