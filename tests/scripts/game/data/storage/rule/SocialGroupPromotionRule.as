package game.data.storage.rule
{
   import com.progrestar.common.lang.Translate;
   import flash.utils.Dictionary;
   import game.mediator.gui.popup.socialgrouppromotion.SocialGroupPromotionDescription;
   
   public class SocialGroupPromotionRule
   {
      
      public static const IDENT_HEROES_LIST:String = "heroesList";
      
      public static const IDENT_ARENA_REWARD:String = "arenaReward";
      
      public static const IDENT_BOSS_VICTORY:String = "bossVictory";
      
      public static const IDENT_BATTLE_DEFEAT:String = "battleDefeat";
      
      public static const IDENT_WELCOME_GIFT:String = "welcomeGift";
       
      
      private var _doNotHideHintText:Boolean;
      
      private var _minLevel:int;
      
      private var _maxLevel:int;
      
      private var _timeToReOpenClosedBlocks:Number;
      
      private var _blocks:Dictionary;
      
      private var _chatButtons:Vector.<SocialGroupPromotionRuleServerChatButton>;
      
      public function SocialGroupPromotionRule(param1:Object)
      {
         var _loc3_:* = null;
         _blocks = new Dictionary();
         _chatButtons = new Vector.<SocialGroupPromotionRuleServerChatButton>();
         super();
         if(param1 && !param1["disabled"])
         {
            this._doNotHideHintText = param1.hintText.doNotHide;
            this._minLevel = param1.minLevel;
            this._maxLevel = param1.maxLevel;
            this._timeToReOpenClosedBlocks = param1.timeToReOpenClosedBlocks;
            var _loc5_:int = 0;
            var _loc4_:* = param1.popupBlock;
            for(var _loc2_ in param1.popupBlock)
            {
               _loc3_ = param1.popupBlock[_loc2_];
               if(_loc3_ && !_loc3_["disabled"])
               {
                  _blocks[_loc2_] = new SocialGroupPromotionRulePopupBlock(_loc2_,_loc3_);
               }
            }
            var _loc7_:int = 0;
            var _loc6_:* = param1.serverChatButtons;
            for(_loc2_ in param1.serverChatButtons)
            {
               _loc3_ = param1.serverChatButtons[_loc2_];
               if(_loc3_ && !_loc3_["disabled"])
               {
                  _chatButtons.push(new SocialGroupPromotionRuleServerChatButton(_loc2_,_loc3_));
                  _chatButtons.sort(sort_chatButtons);
               }
            }
         }
      }
      
      public function get doNotHideHintText() : Boolean
      {
         return _doNotHideHintText;
      }
      
      public function get minLevel() : int
      {
         return _minLevel;
      }
      
      public function get maxLevel() : int
      {
         return _maxLevel;
      }
      
      public function get timeToReOpenClosedBlocks() : int
      {
         return _timeToReOpenClosedBlocks;
      }
      
      public function get hintLocale() : String
      {
         return Translate.translate("LIB_SOCIAL_GROUP_PROMO_HINT");
      }
      
      public function get chatButtons() : Vector.<SocialGroupPromotionDescription>
      {
         var _loc3_:* = null;
         if(!_chatButtons || _chatButtons.length == 0)
         {
            return null;
         }
         var _loc2_:Vector.<SocialGroupPromotionDescription> = new Vector.<SocialGroupPromotionDescription>();
         var _loc5_:int = 0;
         var _loc4_:* = _chatButtons;
         for each(var _loc1_ in _chatButtons)
         {
            _loc3_ = new SocialGroupPromotionDescription();
            _loc3_.ident = _loc1_.key;
            _loc3_.stashIdentBase = "community_promo_chat";
            _loc3_.hoverText = hintLocale;
            _loc3_.href = _loc1_.href;
            _loc3_.messageText = Translate.translate("LIB_SOCIAL_GROUP_PROMO_CHAT_" + _loc1_.key.toUpperCase());
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      public function getBlockDescription(param1:String) : SocialGroupPromotionDescription
      {
         var _loc2_:SocialGroupPromotionRulePopupBlock = _blocks[param1];
         if(!_loc2_)
         {
            return null;
         }
         var _loc3_:SocialGroupPromotionDescription = new SocialGroupPromotionDescription();
         _loc3_.ident = param1;
         _loc3_.stashIdentBase = "community_promo";
         _loc3_.hoverText = hintLocale;
         _loc3_.href = _loc2_.href;
         _loc3_.closeable = _loc2_.closeable;
         _loc3_.messageText = Translate.translate("LIB_SOCIAL_GROUP_PROMO_" + _loc2_.key.toUpperCase());
         return _loc3_;
      }
      
      private function sort_chatButtons(param1:SocialGroupPromotionRuleServerChatButton, param2:SocialGroupPromotionRuleServerChatButton) : int
      {
         return param1.order - param2.order;
      }
   }
}

class SocialGroupPromotionRuleServerChatButton
{
    
   
   public var key:String;
   
   public var href:String;
   
   public var order:int;
   
   function SocialGroupPromotionRuleServerChatButton(param1:String, param2:Object)
   {
      super();
      this.key = param1;
      this.href = param2.href;
      this.order = param2.order;
   }
}

class SocialGroupPromotionRulePopupBlock
{
    
   
   public var key:String;
   
   public var href:String;
   
   public var closeable:Boolean;
   
   function SocialGroupPromotionRulePopupBlock(param1:String, param2:Object)
   {
      super();
      this.key = param1;
      this.href = param2.href;
      this.closeable = param2.closeable;
   }
}
