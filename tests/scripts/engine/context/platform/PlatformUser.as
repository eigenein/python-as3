package engine.context.platform
{
   public class PlatformUser
   {
       
      
      public var firstName:String;
      
      public var lastName:String;
      
      public var birthDate:String;
      
      public var id:String;
      
      public var photoURL:String;
      
      public var male:Boolean;
      
      public function PlatformUser()
      {
         super();
      }
      
      public function get realName() : String
      {
         return firstName + " " + lastName;
      }
   }
}
