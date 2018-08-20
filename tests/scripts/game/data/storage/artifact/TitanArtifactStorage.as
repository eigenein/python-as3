package game.data.storage.artifact
{
   import flash.utils.Dictionary;
   import game.data.storage.DataStorage;
   import game.data.storage.DescriptionStorage;
   import game.data.storage.titan.TitanDescription;
   
   public class TitanArtifactStorage extends DescriptionStorage
   {
       
      
      private var types:Dictionary;
      
      private var battleEffects:Dictionary;
      
      private var statEffectsMap:Dictionary;
      
      public function TitanArtifactStorage()
      {
         types = new Dictionary();
         battleEffects = new Dictionary();
         statEffectsMap = new Dictionary();
         super();
      }
      
      public function getAllArtifactIds() : Vector.<int>
      {
         var _loc3_:* = 0;
         var _loc1_:Vector.<int> = new Vector.<int>();
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for(_loc3_ in _items)
         {
            _loc1_.push(_loc3_);
         }
         return _loc1_;
      }
      
      public function getAllArtifacts() : Vector.<TitanArtifactDescription>
      {
         var _loc1_:Vector.<TitanArtifactDescription> = new Vector.<TitanArtifactDescription>();
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for(var _loc2_ in _items)
         {
            _loc1_.push(_items[_loc2_]);
         }
         return _loc1_;
      }
      
      override public function init(param1:Object) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc6_:* = null;
         if(param1.type)
         {
            var _loc9_:int = 0;
            var _loc8_:* = param1.type;
            for(var _loc7_ in param1.type)
            {
               _loc3_ = new ArtifactType();
               _loc3_.deserialize(param1.type[_loc7_]);
               types[_loc3_.type] = _loc3_;
            }
         }
         if(param1.battleEffect)
         {
            var _loc11_:int = 0;
            var _loc10_:* = param1.battleEffect;
            for(var _loc4_ in param1.battleEffect)
            {
               _loc2_ = new ArtifactBattleEffect();
               _loc2_.deserialize(param1.battleEffect[_loc4_]);
               battleEffects[_loc2_.id] = _loc2_;
               statEffectsMap[_loc4_] = new ArtifactStatEffect(param1.battleEffect[_loc4_]);
            }
         }
         if(param1.id)
         {
            var _loc13_:int = 0;
            var _loc12_:* = param1.id;
            for(var _loc5_ in param1.id)
            {
               _loc6_ = new TitanArtifactDescription(param1.id[_loc5_],statEffectsMap);
               _loc6_.artifactTypeData = types[_loc6_.artifactType];
               _items[_loc6_.id] = _loc6_;
            }
         }
      }
      
      public function getTitanByArtifact(param1:TitanArtifactDescription) : Vector.<TitanDescription>
      {
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc5_:* = undefined;
         var _loc9_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:Vector.<TitanDescription> = new Vector.<TitanDescription>();
         var _loc2_:Vector.<TitanDescription> = DataStorage.titan.getList();
         var _loc3_:int = _loc2_.length;
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc6_ = _loc2_[_loc7_] as TitanDescription;
            if(_loc6_)
            {
               _loc5_ = _loc6_.getArtifacts();
               _loc9_ = _loc5_.length;
               _loc8_ = 0;
               while(_loc8_ < _loc9_)
               {
                  if(_loc5_[_loc8_] == param1)
                  {
                     _loc4_.push(_loc6_);
                  }
                  _loc8_++;
               }
            }
            _loc7_++;
         }
         return _loc4_;
      }
      
      public function getSpiritByElement(param1:String) : TitanArtifactDescription
      {
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var _loc2_ in _items)
         {
            if(_loc2_.artifactType == "spirit" && _loc2_.element == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getArtifactById(param1:int) : TitanArtifactDescription
      {
         return _items[param1] as TitanArtifactDescription;
      }
   }
}
