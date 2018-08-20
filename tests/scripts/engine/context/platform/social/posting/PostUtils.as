package engine.context.platform.social.posting
{
   import com.progrestar.common.lang.Translate;
   import engine.context.GameContext;
   import game.data.storage.DataStorage;
   import game.data.storage.enum.lib.HeroColor;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.posting.SocialGraphAction;
   import game.data.storage.posting.SocialGraphObject;
   import game.data.storage.titan.TitanDescription;
   
   public class PostUtils
   {
       
      
      public function PostUtils()
      {
         super();
      }
      
      public static function fillHeroPostParams(param1:HeroDescription, param2:ActionType, param3:int = 0) : StoryPostParams
      {
         var _loc5_:* = null;
         var _loc11_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc12_:* = null;
         var _loc10_:int = 0;
         var _loc8_:StoryPostParams = new StoryPostParams();
         var _loc14_:SocialGraphObject = DataStorage.posting.getObjectByType(ObjectType.HERO);
         if(GameContext.instance.platformFacade.network == "vkontakte")
         {
            _loc5_ = DataStorage.posting.getVkPhoto(ObjectType.HERO,param1.id,param2);
         }
         else
         {
            _loc11_ = _loc14_.getImage(param1.id,param2,GameContext.instance.localeID);
            _loc4_ = _loc11_.split("/");
            try
            {
               _loc5_ = GameContext.instance.assetIndex.getAssetFile(_loc4_[_loc4_.length - 1]).url;
            }
            catch(error:Error)
            {
               _loc5_ = "";
            }
         }
         _loc8_._image = _loc5_;
         var _loc13_:String = Translate.translate(_loc14_.getName(param1.id));
         _loc8_._objectDescription = Translate.translateArgs(_loc14_.getDesc(param1.id),_loc13_);
         var _loc9_:SocialGraphAction = DataStorage.posting.getActionByType(param2);
         var _loc7_:String = null;
         var _loc17_:* = param2;
         if(ActionType.PROMOTE !== _loc17_)
         {
            if(ActionType.EVOLVE !== _loc17_)
            {
               if(ActionType.OBTAIN === _loc17_)
               {
                  _loc7_ = Translate.translateArgs(_loc9_.desc,_loc13_);
               }
            }
            else
            {
               _loc7_ = Translate.translateArgs(_loc9_.desc,_loc13_,param3);
               _loc8_._actionParam = param3.toString();
            }
         }
         else
         {
            _loc6_ = param1.getColorData(DataStorage.enum.getById_HeroColor(param3)).color;
            _loc12_ = _loc6_.name;
            _loc10_ = _loc6_.ident.indexOf("+");
            if(_loc10_ > -1)
            {
               _loc12_ = _loc12_ + _loc6_.ident.slice(_loc10_,_loc6_.ident.length);
            }
            _loc7_ = Translate.translateArgs(_loc9_.desc,_loc13_,_loc12_);
            _loc8_._actionParam = _loc12_;
         }
         _loc8_._actionDescription = _loc7_;
         _loc8_._object = ObjectType.HERO.type;
         _loc8_._action = param2.type;
         _loc8_._objectId = param1.id;
         return _loc8_;
      }
      
      public static function fillTitanPostParams(param1:TitanDescription, param2:ActionType, param3:int = 0) : StoryPostParams
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc10_:StoryPostParams = new StoryPostParams();
         var _loc8_:SocialGraphObject = DataStorage.posting.getObjectByType(ObjectType.HERO);
         if(GameContext.instance.platformFacade.network == "vkontakte")
         {
            _loc5_ = DataStorage.posting.getVkPhoto(ObjectType.HERO,param1.id,param2);
         }
         else
         {
            _loc6_ = _loc8_.getImage(param1.id,param2,GameContext.instance.localeID);
            _loc4_ = _loc6_.split("/");
            try
            {
               _loc5_ = GameContext.instance.assetIndex.getAssetFile(_loc4_[_loc4_.length - 1]).url;
            }
            catch(error:Error)
            {
               _loc5_ = "";
            }
         }
         _loc10_._image = _loc5_;
         var _loc7_:String = Translate.translate(_loc8_.getName(param1.id));
         _loc10_._objectDescription = Translate.translateArgs(_loc8_.getDesc(param1.id),_loc7_);
         var _loc11_:SocialGraphAction = DataStorage.posting.getActionByType(param2);
         var _loc9_:String = null;
         var _loc14_:* = param2;
         if(ActionType.PROMOTE !== _loc14_)
         {
            if(ActionType.EVOLVE !== _loc14_)
            {
               if(ActionType.OBTAIN === _loc14_)
               {
                  _loc9_ = Translate.translateArgs(_loc11_.desc,_loc7_);
               }
            }
            else
            {
               _loc9_ = Translate.translateArgs(_loc11_.desc,_loc7_,param3);
               _loc10_._actionParam = param3.toString();
            }
         }
         _loc10_._actionDescription = _loc9_;
         _loc10_._object = ObjectType.TITAN.type;
         _loc10_._action = param2.type;
         _loc10_._objectId = param1.id;
         return _loc10_;
      }
   }
}
