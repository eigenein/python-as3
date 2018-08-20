package game.command.intern.skin
{
   import game.data.storage.skin.SkinDescription;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class SkinWithHeroVO
   {
       
      
      public var skin:SkinDescription;
      
      public var hero:PlayerHeroEntry;
      
      public function SkinWithHeroVO(param1:SkinDescription, param2:PlayerHeroEntry)
      {
         super();
         this.skin = param1;
         this.hero = param2;
      }
   }
}
