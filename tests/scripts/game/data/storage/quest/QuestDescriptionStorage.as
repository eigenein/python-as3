package game.data.storage.quest
{
   import flash.utils.Dictionary;
   import game.data.storage.DescriptionStorage;
   import game.data.storage.hero.UnitDescription;
   import game.model.user.quest.PlayerQuestEntry;
   
   public class QuestDescriptionStorage extends DescriptionStorage
   {
       
      
      private var chainById:Dictionary;
      
      private var stateFunctionByIdent:Dictionary;
      
      private var eventFunctionByIdent:Dictionary;
      
      private var heroAdvice:QuestHeroAdviceStorage;
      
      public var translation:QuestDescriptionTaskTranslation;
      
      public function QuestDescriptionStorage()
      {
         chainById = new Dictionary();
         stateFunctionByIdent = new Dictionary();
         eventFunctionByIdent = new Dictionary();
         heroAdvice = new QuestHeroAdviceStorage();
         super();
      }
      
      override public function init(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc8_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         translation = new QuestDescriptionTaskTranslation(param1.translation);
         var _loc10_:int = 0;
         var _loc9_:* = param1.stateFunc;
         for each(_loc2_ in param1.stateFunc)
         {
            _loc6_ = new QuestConditionStateFunction(_loc2_);
            stateFunctionByIdent[_loc6_.ident] = _loc6_;
         }
         var _loc12_:int = 0;
         var _loc11_:* = param1.eventFunc;
         for each(_loc2_ in param1.eventFunc)
         {
            _loc7_ = new QuestConditionEventFunction(_loc2_);
            eventFunctionByIdent[_loc7_.ident] = _loc7_;
         }
         var _loc14_:int = 0;
         var _loc13_:* = param1.chain;
         for each(_loc2_ in param1.chain)
         {
            _loc3_ = new QuestChainDescription(_loc2_);
            chainById[_loc3_.id] = _loc3_;
         }
         var _loc16_:int = 0;
         var _loc15_:* = param1.normal;
         for each(_loc2_ in param1.normal)
         {
            _loc8_ = new QuestNormalDescription(_loc2_);
            _items[_loc8_.id] = _loc8_;
         }
         var _loc18_:int = 0;
         var _loc17_:* = param1.daily;
         for each(_loc2_ in param1.daily)
         {
            _loc5_ = new QuestDailyDescription(_loc2_);
            _items[_loc5_.id] = _loc5_;
         }
         var _loc20_:int = 0;
         var _loc19_:* = param1.special;
         for each(_loc2_ in param1.special)
         {
            _loc4_ = new QuestSpecialDescription(_loc2_);
            _items[_loc4_.id] = _loc4_;
         }
         heroAdvice.init(param1.heroAdvice);
      }
      
      public function getStateFunction(param1:String) : QuestConditionStateFunction
      {
         return stateFunctionByIdent[param1];
      }
      
      public function getEventFunction(param1:String) : QuestConditionEventFunction
      {
         return eventFunctionByIdent[param1];
      }
      
      public function getChain(param1:int) : QuestChainDescription
      {
         return chainById[param1];
      }
      
      public function getQuestById(param1:int) : QuestDescription
      {
         return _items[param1] as QuestDescription;
      }
      
      override public function applyLocale() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _items;
         for each(var _loc1_ in _items)
         {
            _loc1_.setLocaleTaskDescription(translation.translateTask(_loc1_));
         }
         heroAdvice.applyLocale();
      }
      
      public function getQuestAdvice(param1:PlayerQuestEntry, param2:UnitDescription) : Vector.<QuestHeroAdviceDescription>
      {
         return heroAdvice.getQuestAdvice(param1,param2);
      }
      
      public function getEventChainDailyFlagById(param1:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var _loc2_ in _items)
         {
            if(_loc2_ is QuestSpecialDescription && (_loc2_ as QuestSpecialDescription).eventChainId == param1 && !_loc2_.hidden)
            {
               return (_loc2_ as QuestSpecialDescription).daily;
            }
         }
         return false;
      }
   }
}
