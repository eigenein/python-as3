package game.data.storage.rule.ny2018tree
{
   public class NY2018TreeRule
   {
       
      
      private var data:Object;
      
      private var levels:Vector.<NY2018TreeLevel>;
      
      private var _fireworks:NY2018TreeRuleFireworks;
      
      public var decorateActions:Vector.<NY2018TreeDecorateAction>;
      
      public function NY2018TreeRule(param1:Object)
      {
         super();
         this.data = param1;
         decorateActions = new Vector.<NY2018TreeDecorateAction>();
         var _loc5_:int = 0;
         var _loc4_:* = param1.decorateActions;
         for(var _loc2_ in param1.decorateActions)
         {
            decorateActions.push(new NY2018TreeDecorateAction(_loc2_,param1.decorateActions[_loc2_]));
         }
         levels = new Vector.<NY2018TreeLevel>();
         var _loc7_:int = 0;
         var _loc6_:* = param1.levels;
         for(var _loc3_ in param1.levels)
         {
            levels.push(new NY2018TreeLevel(param1.levels[_loc3_]));
         }
         _fireworks = new NY2018TreeRuleFireworks(param1.fireworks,getDecorateActionById(param1.fireworks.decorateAction));
      }
      
      public function get fireworks() : NY2018TreeRuleFireworks
      {
         return _fireworks;
      }
      
      public function getDecorateActionById(param1:uint) : NY2018TreeDecorateAction
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < decorateActions.length)
         {
            if(decorateActions[_loc2_].id == param1)
            {
               return decorateActions[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getLevelById(param1:uint) : NY2018TreeLevel
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < levels.length)
         {
            if(levels[_loc2_].id == param1)
            {
               return levels[_loc2_];
            }
            _loc2_++;
         }
         if(param1 < levels[0].id)
         {
            return levels[0];
         }
         if(param1 > levels[levels.length - 1].id)
         {
            return levels[levels.length - 1];
         }
         return null;
      }
      
      public function getAssetLevelByLevel(param1:int) : int
      {
         var _loc3_:* = null;
         var _loc2_:int = 1;
         if(levels && levels.length)
         {
            _loc3_ = getLevelById(param1);
            if(_loc3_)
            {
               _loc2_ = _loc3_.assetLevel;
            }
            else if(param1 < levels[0].id)
            {
               _loc2_ = levels[0].assetLevel;
            }
            else
            {
               _loc2_ = levels[levels.length - 1].assetLevel;
            }
         }
         return _loc2_;
      }
   }
}
