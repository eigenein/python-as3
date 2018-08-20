package game.command.rpc.login
{
   import engine.context.GameContext;
   import engine.context.platform.PlatformUser;
   import engine.context.platform.social.FBSocialFacadeHelper;
   import engine.context.platform.social.OKSocialFacadeHelper;
   import engine.context.platform.social.VKSocialFacadeHelper;
   import engine.context.platform.social.referrer.GMRPlatformFacadeReferrerInfo;
   import game.command.rpc.RpcRequest;
   import game.model.GameModel;
   
   public class LoginRPCRequest
   {
       
      
      public function LoginRPCRequest(param1:RpcRequest)
      {
         var _loc9_:* = null;
         var _loc8_:* = undefined;
         var _loc12_:* = null;
         var _loc13_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc15_:* = null;
         var _loc11_:* = null;
         var _loc14_:* = null;
         var _loc2_:* = null;
         var _loc7_:* = null;
         var _loc16_:* = null;
         var _loc6_:* = null;
         super();
         param1.writeRequest(new RpcRequest("userGetInfo"));
         if(GameModel.instance.context.platformFacade.appFriends && GameModel.instance.context.platformFacade.notAppFriends)
         {
            _loc9_ = new RpcRequest("friendsGetInfo");
            _loc8_ = GameModel.instance.context.platformFacade.appFriends.slice();
            if(GameModel.instance.context.platformFacade.network != "facebook")
            {
               _loc8_ = _loc8_.concat(GameModel.instance.context.platformFacade.notAppFriends);
            }
            _loc12_ = [];
            _loc13_ = _loc8_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc13_)
            {
               _loc12_[_loc5_] = _loc8_[_loc5_].id;
               _loc5_++;
            }
            _loc9_.writeParam("ids",_loc12_);
            param1.writeRequest(_loc9_);
         }
         var _loc4_:RpcRequest = new RpcRequest("billingGetAll");
         if(GameModel.instance.context.platformFacade.network == "facebook")
         {
            _loc3_ = FBSocialFacadeHelper.fbCurrency;
            if(_loc3_)
            {
               _loc4_.writeParam("currency",_loc3_.user_currency);
            }
         }
         param1.writeRequest(_loc4_);
         if(GameModel.instance.context.platformFacade.network == "vkontakte")
         {
            _loc15_ = new RpcRequest("offerVk");
            _loc15_.writeParam("vk_sid",VKSocialFacadeHelper.vk_sid);
            _loc15_.writeParam("vk_lead_id",VKSocialFacadeHelper.vk_lead_id);
            _loc15_.writeParam("vk_uid",VKSocialFacadeHelper.vk_uid);
            _loc15_.writeParam("vk_hash",VKSocialFacadeHelper.vk_hash);
            param1.writeRequest(_loc15_);
         }
         if(GameModel.instance.context.platformFacade.network == "odnoklassniki" || GameContext.instance.consoleEnabled)
         {
            _loc11_ = new RpcRequest("offerOkVip");
            if(GameContext.instance.consoleEnabled)
            {
               OKSocialFacadeHelper.session_key = "sk";
               OKSocialFacadeHelper.session_secret_key = "ssk";
            }
            _loc11_.writeParam("session_key",OKSocialFacadeHelper.session_key);
            _loc11_.writeParam("session_secret_key",OKSocialFacadeHelper.session_secret_key);
            param1.writeRequest(_loc11_);
         }
         if(GameModel.instance.context.platformFacade.network == "facebook")
         {
            _loc14_ = new RpcRequest("offerTrialPay");
            _loc14_.writeParam("clickId",FBSocialFacadeHelper.tpClickId);
            _loc14_.writeParam("type",FBSocialFacadeHelper.tpTypeId);
            _loc14_.writeParam("timeLimit",FBSocialFacadeHelper.tpTimeLimit);
            param1.writeRequest(_loc14_);
         }
         if(OKSocialFacadeHelper._agdvf_id || VKSocialFacadeHelper._agdvf_id)
         {
            _loc2_ = new RpcRequest("offerAdvGame");
            if(GameModel.instance.context.platformFacade.network == "odnoklassniki")
            {
               _loc2_.writeParam("_agdvf_id",OKSocialFacadeHelper._agdvf_id);
            }
            if(GameModel.instance.context.platformFacade.network == "vkontakte")
            {
               _loc2_.writeParam("_agdvf_id",VKSocialFacadeHelper._agdvf_id);
            }
            param1.writeRequest(_loc2_);
         }
         if(VKSocialFacadeHelper.admitad_uid)
         {
            _loc7_ = new RpcRequest("offerAdmitad");
            if(GameModel.instance.context.platformFacade.network == "vkontakte")
            {
               _loc7_.writeParam("publisher_id",VKSocialFacadeHelper.admitad_publisher_id);
               _loc7_.writeParam("admitad_uid",VKSocialFacadeHelper.admitad_uid);
            }
            param1.writeRequest(_loc7_);
         }
         if(GameModel.instance.context.platformFacade.network == "gamesmailru")
         {
            _loc16_ = GameModel.instance.context.platformFacade.referrer as GMRPlatformFacadeReferrerInfo;
            if(_loc16_ && _loc16_.code)
            {
               _loc6_ = new RpcRequest("redeemGmrGiftCode");
               _loc6_.writeParam("code",_loc16_.code);
               param1.writeRequest(_loc6_);
            }
         }
         param1.writeRequest(new RpcRequest("inventoryGet"));
         param1.writeRequest(new RpcRequest("heroGetAll"));
         param1.writeRequest(new RpcRequest("titanGetAll"));
         param1.writeRequest(new RpcRequest("titanSpiritGetAll"));
         param1.writeRequest(new RpcRequest("missionGetAll"));
         param1.writeRequest(new RpcRequest("missionGetReplace"));
         param1.writeRequest(new RpcRequest("dailyBonusGetInfo"));
         param1.writeRequest(new RpcRequest("getTime"));
         param1.writeRequest(new RpcRequest("teamGetAll"));
         param1.writeRequest(new RpcRequest("questGetAll"));
         param1.writeRequest(new RpcRequest("questGetEvents"));
         param1.writeRequest(new RpcRequest("mailGetAll"));
         param1.writeRequest(new RpcRequest("arenaGetAll"));
         param1.writeRequest(new RpcRequest("socialQuestGetInfo"));
         param1.writeRequest(new RpcRequest("userGetAvailableAvatars"));
         param1.writeRequest(new RpcRequest("settingsGetAll"));
         param1.writeRequest(new RpcRequest("subscriptionGetInfo"));
         param1.writeRequest(new RpcRequest("zeppelinGiftGet"));
         param1.writeRequest(new RpcRequest("tutorialGetInfo"));
         param1.writeRequest(new RpcRequest("offerGetAll"));
         param1.writeRequest(new RpcRequest("splitGetAll"));
         param1.writeRequest(new RpcRequest("billingGetLast"));
         param1.writeRequest(new RpcRequest("artifactGetChestLevel"));
         param1.writeRequest(new RpcRequest("titanArtifactGetChest"));
         param1.writeRequest(new RpcRequest("titanGetSummoningCircle"));
         param1.writeRequest(new RpcRequest("newYearGetInfo"));
         param1.writeRequest(new RpcRequest("clanWarGetBriefInfo"));
         param1.writeRequest(new RpcRequest("clanWarGetWarlordInfo"));
         var _loc10_:RpcRequest = new RpcRequest("chatGetAll");
         _loc10_.writeParam("chatType","clan");
         param1.writeRequest(_loc10_);
         param1.writeRequest(new RpcRequest("chatGetInfo"));
         param1.writeRequest(new RpcRequest("clanGetInfo"));
         param1.writeRequest(new RpcRequest("heroesMerchantGet"));
         param1.writeRequest(new RpcRequest("freebieHaveGroup"));
         param1.writeRequest(new RpcRequest("pirateTreasureIsAvailable"));
         param1.writeRequest(new RpcRequest("expeditionGet"));
         param1.writeRequest(new RpcRequest("hallOfFameGetTrophies"));
         param1.writeRequest(new RpcRequest("titanArenaGetChestReward"));
         param1.writeRequest(new RpcRequest("bossGetAll"));
      }
   }
}
