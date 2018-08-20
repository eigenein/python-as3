package game.data.storage.artifact
{
   import flash.utils.Dictionary;
   import game.data.storage.DataStorage;
   import game.data.storage.DescriptionStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.UnitDescription;
   
   public class ArtifactStorage extends DescriptionStorage
   {
       
      
      private var types:Dictionary;
      
      private var battleEffects:Dictionary;
      
      public function ArtifactStorage()
      {
         types = new Dictionary();
         battleEffects = new Dictionary();
         super();
      }
      
      public function getAllArtifactIds() : Vector.<int>
      {
         var _loc1_:Vector.<int> = new Vector.<int>();
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for(var _loc2_ in _items)
         {
            _loc1_.push(int(_loc2_));
         }
         return _loc1_;
      }
      
      override public function init(param1:Object) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc7_:* = null;
         var _loc5_:int = 0;
         if(param1.type)
         {
            var _loc10_:int = 0;
            var _loc9_:* = param1.type;
            for(var _loc8_ in param1.type)
            {
               _loc3_ = new ArtifactType();
               _loc3_.deserialize(param1.type[_loc8_]);
               types[_loc3_.type] = _loc3_;
            }
         }
         if(param1.battleEffect)
         {
            var _loc12_:int = 0;
            var _loc11_:* = param1.battleEffect;
            for(var _loc4_ in param1.battleEffect)
            {
               _loc2_ = new ArtifactBattleEffect();
               _loc2_.deserialize(param1.battleEffect[_loc4_]);
               battleEffects[_loc2_.id] = _loc2_;
            }
         }
         if(param1.id)
         {
            var _loc14_:int = 0;
            var _loc13_:* = param1.id;
            for(var _loc6_ in param1.id)
            {
               _loc7_ = new ArtifactDescription(param1.id[_loc6_]);
               _loc7_.artifactTypeData = types[_loc7_.artifactType];
               _loc5_ = 0;
               while(_loc5_ < _loc7_.battleEffects.length)
               {
                  _loc7_.battleEffectsData.push(battleEffects[_loc7_.battleEffects[_loc5_]]);
                  _loc5_++;
               }
               _items[_loc7_.id] = _loc7_;
            }
         }
      }
      
      public function getHeroByArtifact(param1:ArtifactDescription) : Vector.<HeroDescription>
      {
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc5_:* = undefined;
         var _loc9_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:Vector.<HeroDescription> = new Vector.<HeroDescription>();
         var _loc2_:Vector.<UnitDescription> = DataStorage.hero.getList();
         var _loc3_:int = _loc2_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc7_ = _loc2_[_loc6_] as HeroDescription;
            if(_loc7_)
            {
               _loc5_ = _loc7_.getArtifacts();
               _loc9_ = _loc5_.length;
               _loc8_ = 0;
               while(_loc8_ < _loc9_)
               {
                  if(_loc5_[_loc8_] == param1)
                  {
                     _loc4_.push(_loc7_);
                  }
                  _loc8_++;
               }
            }
            _loc6_++;
         }
         return _loc4_;
      }
   }
}
