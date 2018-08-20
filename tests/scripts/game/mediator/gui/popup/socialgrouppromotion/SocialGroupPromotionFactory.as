package game.mediator.gui.popup.socialgrouppromotion
{
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.view.popup.socialgrouppromotion.SocialGroupPromotionBlock;
   
   public class SocialGroupPromotionFactory
   {
       
      
      public function SocialGroupPromotionFactory()
      {
         super();
      }
      
      public static function welcomeGift() : SocialGroupPromotionBlock
      {
         return createSideBarBlock("welcomeGift");
      }
      
      public static function arenaReward() : SocialGroupPromotionBlock
      {
         return createSideBarBlock("arenaReward");
      }
      
      public static function battleDefeat(param1:String) : SocialGroupPromotionBlock
      {
         return createSideBarBlock(param1 + "Defeat");
      }
      
      public static function heroListSideBar() : SocialGroupPromotionBlock
      {
         return createSideBarBlock("heroesList");
      }
      
      public static function bossVictory() : SocialGroupPromotionBlock
      {
         return createSideBarBlock("bossVictory");
      }
      
      public static function serverChatButtonsMediators(param1:PopupStashEventParams) : Vector.<SocialGroupPromotionMediator>
      {
         var _loc4_:Player = GameModel.instance.player;
         var _loc3_:Vector.<SocialGroupPromotionDescription> = DataStorage.rule.socialGroupPromotionRule.chatButtons;
         if(!_loc3_)
         {
            return null;
         }
         var _loc2_:Vector.<SocialGroupPromotionMediator> = new Vector.<SocialGroupPromotionMediator>();
         var _loc7_:int = 0;
         var _loc6_:* = _loc3_;
         for each(var _loc5_ in _loc3_)
         {
            _loc2_.push(new SocialGroupPromotionMediator(_loc4_,_loc5_,param1));
         }
         return _loc2_;
      }
      
      private static function createSideBarBlock(param1:String) : SocialGroupPromotionBlock
      {
         var _loc5_:Player = GameModel.instance.player;
         if(SocialGroupPromotionSettingsUtil.getIsClosed(_loc5_,param1))
         {
            return null;
         }
         var _loc2_:int = DataStorage.rule.socialGroupPromotionRule.minLevel;
         var _loc3_:int = DataStorage.rule.socialGroupPromotionRule.maxLevel;
         if(_loc2_ && _loc5_.levelData.level.level < _loc2_)
         {
            return null;
         }
         if(_loc3_ && _loc5_.levelData.level.level > _loc3_)
         {
            return null;
         }
         var _loc6_:SocialGroupPromotionDescription = DataStorage.rule.socialGroupPromotionRule.getBlockDescription(param1);
         if(_loc6_ == null)
         {
            return null;
         }
         var _loc4_:SocialGroupPromotionMediator = new SocialGroupPromotionMediator(_loc5_,_loc6_);
         return new SocialGroupPromotionBlock(_loc4_);
      }
   }
}
