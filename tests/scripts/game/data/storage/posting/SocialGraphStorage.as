package game.data.storage.posting
{
   import engine.context.platform.social.posting.ActionType;
   import engine.context.platform.social.posting.ObjectType;
   import flash.utils.Dictionary;
   
   public class SocialGraphStorage
   {
       
      
      private var _objects:Dictionary;
      
      private var _actions:Dictionary;
      
      private var _vkPhotos:Dictionary;
      
      public function SocialGraphStorage()
      {
         _objects = new Dictionary();
         _actions = new Dictionary();
         _vkPhotos = new Dictionary();
         super();
      }
      
      public function init(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = param1.object;
         for each(_loc2_ in param1.object)
         {
            _loc3_ = new SocialGraphObject(_loc2_);
            _objects[_loc3_.ident] = _loc3_;
         }
         var _loc8_:int = 0;
         var _loc7_:* = param1.action;
         for each(_loc2_ in param1.action)
         {
            _loc4_ = new SocialGraphAction(_loc2_);
            _actions[_loc4_.ident] = _loc4_;
         }
         var _loc10_:int = 0;
         var _loc9_:* = param1.vkMap;
         for each(_loc2_ in param1.vkMap)
         {
            _vkPhotos[getKey(_loc2_.objectType,_loc2_.objectId,_loc2_.actionType)] = _loc2_.mediaId;
         }
      }
      
      public function getVkPhoto(param1:ObjectType, param2:int, param3:ActionType) : String
      {
         return _vkPhotos[getKey(param1.type,param2,param3.type)];
      }
      
      public function getObjectByType(param1:ObjectType) : SocialGraphObject
      {
         return _objects[param1.type];
      }
      
      public function getActionByType(param1:ActionType) : SocialGraphAction
      {
         return _actions[param1.type];
      }
      
      private function getKey(param1:String, param2:int, param3:String) : String
      {
         return param1 + "_" + param2 + "_" + param3;
      }
   }
}
