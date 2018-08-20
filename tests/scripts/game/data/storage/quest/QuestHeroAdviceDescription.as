package game.data.storage.quest
{
   import com.progrestar.common.lang.Translate;
   import flash.utils.Dictionary;
   import game.data.storage.DescriptionBase;
   
   public class QuestHeroAdviceDescription extends DescriptionBase
   {
       
      
      public var text_id:int;
      
      public var ident:Array;
      
      public var hero_character:Dictionary;
      
      public var hero_role:Dictionary;
      
      public var hero_id:Dictionary;
      
      private var _translated:Boolean;
      
      private var _requirement_refillableId:Vector.<int>;
      
      private var _requirement_mechanicIdent:String;
      
      private var _requirement_skillsNotMaxed:Boolean;
      
      public function QuestHeroAdviceDescription(param1:Object)
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = 0;
         _loc3_ = 0;
         _loc2_ = 0;
         _loc3_ = 0;
         _loc2_ = 0;
         var _loc4_:int = 0;
         super();
         text_id = param1.text_id;
         ident = param1.ident;
         hero_role = new Dictionary();
         if(param1.hero_role)
         {
            _loc2_ = param1.hero_role.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               hero_role[param1.hero_role[_loc3_]] = 1;
               _loc3_++;
            }
         }
         hero_id = new Dictionary();
         if(param1.hero_id)
         {
            _loc2_ = param1.hero_id.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               hero_id[param1.hero_id[_loc3_]] = 1;
               _loc3_++;
            }
         }
         hero_character = new Dictionary();
         if(param1.hero_character)
         {
            _loc2_ = param1.hero_character.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               hero_character[param1.hero_character[_loc3_]] = 1;
               _loc3_++;
            }
         }
         if(param1.requirement)
         {
            if(param1.requirement.refillable && param1.requirement.refillable is Array)
            {
               _requirement_refillableId = new Vector.<int>();
               _loc2_ = param1.requirement.refillable.length;
               _loc4_ = 0;
               while(_loc4_ < _loc2_)
               {
                  _requirement_refillableId.push(param1.requirement.refillable[_loc4_]);
                  _loc4_++;
               }
            }
            if(param1.requirement.mechanic)
            {
               _requirement_mechanicIdent = param1.requirement.mechanic;
            }
            if(param1.requirement.skillsNotMaxed)
            {
               _requirement_skillsNotMaxed = true;
            }
         }
      }
      
      public function get translated() : Boolean
      {
         return _translated;
      }
      
      public function get requirement_refillableId() : Vector.<int>
      {
         return _requirement_refillableId;
      }
      
      public function get requirement_mechanicIdent() : String
      {
         return _requirement_mechanicIdent;
      }
      
      public function get requirement_skillsNotMaxed() : Boolean
      {
         return _requirement_skillsNotMaxed;
      }
      
      override public function applyLocale() : void
      {
         _translated = Translate.has("LIB_QUEST_HERO_ADVICE_" + text_id);
         _name = Translate.translate("LIB_QUEST_HERO_ADVICE_" + text_id);
      }
      
      public function roleMatch(param1:Array) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(hero_role[param1[_loc3_]])
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function characterMatch(param1:String) : Boolean
      {
         return hero_character[param1] == 1;
      }
   }
}
