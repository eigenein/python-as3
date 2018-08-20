package game.data.storage.tutorial
{
   import flash.utils.Dictionary;
   
   public class TutorialDescriptionStorage
   {
       
      
      private const tutorialById:Dictionary = new Dictionary();
      
      private const chainById:Dictionary = new Dictionary();
      
      public function TutorialDescriptionStorage()
      {
         super();
      }
      
      public function init(param1:Object) : void
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc8_:int = 0;
         var _loc7_:* = param1.chain;
         for each(var _loc2_ in param1.chain)
         {
            _loc3_ = new TutorialTaskChainDescription(_loc2_);
            chainById[_loc2_.id] = _loc3_;
         }
         var _loc12_:int = 0;
         var _loc11_:* = param1.group;
         for each(_loc2_ in param1.group)
         {
            _loc5_ = new TutorialDescription(_loc2_);
            tutorialById[_loc5_.id] = _loc5_;
            var _loc10_:int = 0;
            var _loc9_:* = _loc2_.chains;
            for each(var _loc6_ in _loc2_.chains)
            {
               _loc3_ = chainById[_loc6_];
               _loc5_.addChain(_loc3_);
            }
         }
         var _loc14_:int = 0;
         var _loc13_:* = param1.task;
         for each(_loc2_ in param1.task)
         {
            _loc4_ = new TutorialTaskDescription(_loc2_);
            _loc3_ = chainById[_loc2_.chainId];
            _loc3_.addTask(_loc4_);
         }
      }
      
      public function getList() : Vector.<TutorialDescription>
      {
         var _loc1_:Vector.<TutorialDescription> = new Vector.<TutorialDescription>();
         var _loc4_:int = 0;
         var _loc3_:* = tutorialById;
         for each(var _loc2_ in tutorialById)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function getById(param1:int) : TutorialDescription
      {
         return tutorialById[param1];
      }
      
      public function getChainByIdent(param1:String) : TutorialTaskChainDescription
      {
         var _loc4_:int = 0;
         var _loc3_:* = chainById;
         for each(var _loc2_ in chainById)
         {
            if(_loc2_.ident == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getChainById(param1:int) : TutorialTaskChainDescription
      {
         var _loc4_:int = 0;
         var _loc3_:* = chainById;
         for each(var _loc2_ in chainById)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}
