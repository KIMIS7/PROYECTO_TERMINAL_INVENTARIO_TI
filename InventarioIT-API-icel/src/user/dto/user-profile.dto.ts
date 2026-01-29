export class UserProfileDto {
  success: boolean;
  message: string;
  data: {
    userInfo: {
      buyerID: string;
      name: string;
      emailAddress: string;
      approvalPerson: string;
    };
    companies: string[];
  };
}
